#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
# Initial data - Insert data script
"""
import sys
import logging
import os
import time
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import thriftpy
from pika_thriftpy_client import TPikaTransport
from thriftpy.protocol.binary import TBinaryProtocol
from thriftpy.thrift import TClient

thrift_file_path = os.path.join(os.path.dirname('libraries/mbobject_vehicle_counting/'), 'data.thrift')
thriftpy.load(thrift_file_path, module_name="vehicle_counting_thrift")
from vehicle_counting_thrift import (DataService,
                                     VehicleCountingDirection,
                                     VehicleCountingOrientation,
                                     VehicleCountingSite,
                                     VehicleCountingData,
                                     VehicleCountingPushData)

SOURCE = "robot"
SITES = [
    {
        'id': '001',
        'lon': -74.09952163,
        'lat': 4.68096794,
        'num_lanes': 2,
        'orientation': VehicleCountingOrientation.FOUR_DIRECTIONS,
        'traffic': [
            { 'flow': 100, 'speed': 400, 'direction': VehicleCountingDirection.NORTH },
            { 'flow': 200, 'speed': 300, 'direction': VehicleCountingDirection.SOUTH },
            { 'flow': 300, 'speed': 200, 'direction': VehicleCountingDirection.EAST },
            { 'flow': 400, 'speed': 100, 'direction': VehicleCountingDirection.WEST },
        ]
    },
    {
        'id': '002',
        'lon': -74.10690307,
        'lat': 4.67172909,
        'num_lanes': 1,
        'orientation': VehicleCountingOrientation.NORTH_SOUTH,
        'traffic': [
            { 'flow': 100, 'speed': 200, 'direction': VehicleCountingDirection.NORTH },
            { 'flow': 200, 'speed': 100, 'direction': VehicleCountingDirection.SOUTH },
        ]
    },
    {
        'id': '003',
        'lon': -74.11325454,
        'lat': 4.66471432,
        'num_lanes': 2,
        'orientation': VehicleCountingOrientation.EAST_WEST,
        'traffic': [
            { 'flow': 100, 'speed': 200, 'direction': VehicleCountingDirection.EAST },
            { 'flow': 200, 'speed': 100, 'direction': VehicleCountingDirection.WEST },
        ]
    },
    {
        'id': '004',
        'lon': -74.12029266,
        'lat': 4.65633072,
        'num_lanes': 1,
        'orientation': VehicleCountingOrientation.SOUTH,
        'traffic': [
            { 'flow': 100, 'speed': 200, 'direction': VehicleCountingDirection.SOUTH }
        ]
    },
    {
        'id': '005',
        'lon': -74.06913757,
        'lat': 4.62296644,
        'orientation': VehicleCountingOrientation.SOUTH,
        'traffic': [
            { 'flow': 100, 'direction': VehicleCountingDirection.SOUTH }
        ]
    }
]

log = logging.getLogger(__name__)

QUEUE = "vehiclecounting.mb.robot"
RABBITMQ_URL = "amqp://localhost/"


def generateData(client):
    log.info("generating data")
    sites = []
    data = []
    current_datetime = datetime.utcnow()

    # SITES
    for i, site in enumerate(SITES):
        item = VehicleCountingSite(
            id=site["id"],
            latitude=site["lat"],
            longitude=site["lon"],
            updated_at=datetimeToUnixTimeMs(current_datetime),
            name="TestingCountingSite %s" % site["id"],
            orientation=site["orientation"],
            num_lanes=site.get("num_lanes", None)
        )
        sites.append(item)

        # month_ago
        one_month_ago = current_datetime + relativedelta(months=-1)
        days_in_between = (current_datetime - one_month_ago).days

        # DATA
        for n, traffic in enumerate(site["traffic"]):
            for k in xrange(0, days_in_between):
                for j in xrange(0, 24):
                    item = VehicleCountingData(
                        id=site["id"],
                        direction=traffic["direction"],
                        lane=(n + 1),
                        time=datetimeToUnixTimeMs(current_datetime - timedelta(hours=j, days=k)),
                        speed=traffic.get("speed", None),
                        occupancy=(n + 1) * 25,
                        flow=traffic["flow"],
                        integration_period=60*60
                    )
                    data.append(item)

    client.push(SOURCE, VehicleCountingPushData(sites=sites, data=data))


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


def datetimeToUnixTimeMs(dt):
    epoch = datetime.utcfromtimestamp(0)
    delta = dt - epoch
    return int(delta.total_seconds() * 1000)


if __name__ == "__main__":
    initLog(logging.INFO)
    client = initQueueConnection(QUEUE, host_url=RABBITMQ_URL)
    start_time = time.time()
    generateData(client)
    elapsed_time = time.time() - start_time
    log.info("Connector process time: %s", elapsed_time)
