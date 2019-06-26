#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Simulator

- Generates 20 road_segment with 1..road_segment["num_lanes"] items of data each
- GPS ROAD_SEGMENTSS coordinates are pre-defined in Barcelona.
"""
import argparse
import sys
import logging
import random
import os
import time
from datetime import datetime, timedelta
import thriftpy
import csv

current_dir = os.path.dirname(__file__)
from mbobject.pika_thrift.transports import TPikaTransport
from thriftpy.protocol.binary import TBinaryProtocol
from thriftpy.thrift import TClient
thriftpy.load("data.thrift", module_name="traffic_thrift")
from traffic_thrift import (DataService,
                            Direction,
                            RoadSegment,
                            Lane,
                            LaneMeasurement,
                            TrafficPushData)
from mbobject import utils

SOURCE = "robot"
QUEUE = "traffic.mb.robot"
RABBITMQ_URL = "amqp://development.mobility.wocs3.com/"

log = logging.getLogger(__name__)


parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument("--interval", type=int, default=1000, help="generate data interval in seconds")
parser.add_argument("--scenario", type=str, default="scenario-1.csv")
parser.add_argument("--one_time", type=bool, default=True)
parser.add_argument("--disable", type=bool, default=False)
args = parser.parse_args()


def generateData(args, client):
    with open(args.scenario) as csvfile:
        road_segments = []
        lanes = []
        data = []
        rs_id = []
        lane_id = []
        reader = csv.DictReader(csvfile)
        second = timedelta(seconds=1)
        for row in reader:
            print row
            rs = RoadSegment(
                id=row['roadsegment'],
                latitude=float(row['lat']),
                longitude=float(row['lon']),
                updated_at=utils.datetimeToUnixTimeMs(datetime.strptime(row['timestamp'], '%Y-%m-%dT%H:%M:%SZ')),
                name=row['name'],
                orientation=int(row['Orientation'])
            )

            lane = Lane(
                id=row['lane_id'],
                direction=int(row['direction']),
                road_segment_id=row['roadsegment'],
                lane_num=int(row['lane_num'])
            )
            if row['avg_length_m'] == "null":
                avg_length_m = None
            else:
                avg_length_m = float(row['avg_length_m'])
            measurement = LaneMeasurement(
                road_segment_id=row['roadsegment'],
                lane_id=row['lane_id'],
                time_unix_ms=utils.datetimeToUnixTimeMs(datetime.strptime(row['timestamp'], '%Y-%m-%dT%H:%M:%SZ')  + second),
                avg_speed_kmh=int(row['avg_speed_kmh']),
                occupancy_percentage=int(row['occupancy_percentage']),
                avg_length_m=avg_length_m,
                number_vehicles=int(row['number_vehicles']),
                congested=True if 'True' in row['congested'] else False,
                period_inverted=True if 'True' in row['period_inverted'] else False,
                integration_period_s=int(row['integration_time'])
            )
            data.append(measurement)
            if row['roadsegment'] + row['lane_id']  not in lane_id:
                lane_id.append(row['roadsegment'] + row['lane_id'])
                lanes.append(lane)
            if row['roadsegment'] not in rs_id:
                rs_id.append(row['roadsegment'])
                road_segments.append(rs)

    client.add_road_segments(SOURCE, road_segments=road_segments)
    client.add_lanes(SOURCE, lanes=lanes)
    if args.disable:
        client.disable_roadsegments(SOURCE, ['2'])
    client.add_lane_measurements(SOURCE, lanes_data=data)

def connectorLoop(args, client):
    while True:
        start_time = time.time()
        generateData(args, client)
        elapsed_time = time.time() - start_time
        log.info("Connector process time: %s", elapsed_time)
        sleep_interval = args.interval - elapsed_time
        if(sleep_interval > 0):
            # Only sleep what's necessary so the interval is applied
            # between the beginning of each run
            time.sleep(sleep_interval)


def initQueueConnection(queue, host_url="amqp://mbrabbitmq/"):
    if "?" in host_url:
        host_url += "&heartbeat_interval=0"
    else:
        host_url += "?heartbeat_interval=0"
    print host_url
    protocol = TBinaryProtocol(TPikaTransport(host_url, "data_msgs", queue))
    client = TClient(DataService, protocol)
    return client


def initLog(level):
    log_format = "%(asctime)s %(name)-12s %(funcName)20s %(levelname)-8s %(message)s"
    logging.basicConfig(stream=sys.stdout, level=level, format=log_format)


if __name__ == "__main__":
    initLog(logging.INFO)
    #args = parser.parse_args()
    start_time = time.time()
    elapsed_time = time.time() - start_time
    logging.info("Connector process time: %s", elapsed_time)
    client = initQueueConnection(QUEUE, host_url=RABBITMQ_URL)
    if args.one_time:
        generateData(args, client)
        logging.info("Connector process time: %s", elapsed_time)
    else:
        connectorLoop(args, client)
