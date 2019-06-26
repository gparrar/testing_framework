#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
"""
import argparse
import sys
import logging
import random
import os
import time
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import thriftpy
from pika_thriftpy_client import TPikaTransport
from thriftpy.protocol.binary import TBinaryProtocol
from thriftpy.thrift import TClient

thrift_file_path = os.path.join(os.path.dirname('libraries/mbobject_tracking/'), 'data.thrift')
thriftpy.load(thrift_file_path, module_name="tracking_thrift")
from tracking_thrift import (DataService, TrackingElement, TrackingType,
                             TrackingData, TrackingPushData)


SOURCE = "robot"

TYPES = [{
    'id': 1,
    'name': 'Tracking Elements 1'
}]

ELEMENTS = [{
    'id': '001',
    'name': 'AGENT-001',
    'type': 1,
    'description': 'This is the Agent-001',
    'speed': 10,
    'inactive': False,
    'lat': '',
    'lon': ''
}]

QUEUE = "tracking.mbone.robot"
RABBITMQ_URL = "amqp://localhost/"

BOUNDING_BOXES = [[(-74.0847158432006, 4.733682694), (-74.0761971473693, 4.7211512756), (-74.0761971473693, 4.733682694)],
                  [(-74.1659975051879, 4.645166701), (-74.1407632827758, 4.614368475), (-74.1407632827758, 4.645166701)],
                  [(-74.1659975051879, 4.645166701), (-74.1407632827758, 4.614368475), (-74.1407632827758, 4.645166701)],
                  [(-74.1404199600219, 4.760690766), (-74.1315793991088, 4.757055537), (-74.1315793991088, 4.760690766)],
                  [(-74.179515838623, 4.3676357697), (-74.1426086425781, 4.315600462), (-74.1426086425781, 4.3676357697)],
                  [(-74.0937280654907, 4.5694733924), (-74.0842652320861, 4.55852190112494), (-74.0842652320861, 4.5694733924)]
                  ]


log = logging.getLogger(__name__)


def getRandomLonLatInBox(item):
    lon = random.uniform(BOUNDING_BOXES[item][0][0], BOUNDING_BOXES[item][2][0])
    lat = random.uniform(BOUNDING_BOXES[item][1][1], BOUNDING_BOXES[item][2][1])
    return lon, lat


def generateData(client):
    log.info("generating data")
    types = []
    elements = []
    data = []
    current_datetime = datetime.utcnow()

    # TYPES
    for t in TYPES:
        item = TrackingType(
            id=t['id'],
            name=t['name'])
        types.append(item)

    # ELEMENTS
    for e in ELEMENTS:
        item = TrackingElement(
            id=e['id'],
            name=e['name'],
            type=e['type'])
        elements.append(item)

    # month_ago
        one_month_ago = current_datetime + relativedelta(months=-1)
        days_in_between = (current_datetime - one_month_ago).days

    # DATA
    for i, element in enumerate(ELEMENTS):
        for k in xrange(0, days_in_between):
            for j in xrange(0, 24):
                lon, lat = getRandomLonLatInBox(i)
                item = TrackingData(
                    id=element['id'],
                    time=datetimeToUnixTimeMs(current_datetime - timedelta(hours=j, days=k)),
                    longitude=lon,
                    latitude=lat,
                    inactive=element['inactive'],
                    speed=element.get("speed", None)
                )
                data.append(item)

    client.push(SOURCE, TrackingPushData(types=types, elements=elements,
                                         data=data))


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
