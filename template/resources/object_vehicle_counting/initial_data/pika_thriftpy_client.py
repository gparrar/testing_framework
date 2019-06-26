#!/usr/bin/env python
import pika
import sys
import os
import thriftpy
from cStringIO import StringIO
from thriftpy.transport import TTransportBase
import time
import logging

log = logging.getLogger(__name__)


# Based on https://github.com/GaretJax/pyamqplib-thrift/tree/master/example"
class TPikaTransport(TTransportBase):

    def __init__(self, url, exchange, routing_key):
        # Input and output buffers
        self.__wbuf = StringIO()
        self.parameters = pika.URLParameters(url)
        self.exchange = exchange
        self.routing_key = routing_key
        self.connect()

    def write(self, buf):
        """
        Writes some data to the output buffer.
        """
        self.__wbuf.write(buf)

    def flush(self):
        """
        Sends the message and clears the output buffer.
        """
        try:
            message = self.__wbuf.getvalue()
            self.__wbuf = StringIO()
            self.channel.basic_publish(
                exchange=self.exchange,  # 'data_msgs',
                routing_key=self.routing_key,  # 'traffic'
                body=message,
                properties=pika.BasicProperties(
                    delivery_mode=2,  # make message persistent
                )
            )
        except pika.exceptions.ConnectionClosed:
            log.debug('reconnecting to queue')
            self.connect()

    def connect(self):
        connected = False
        while not connected:
            try:
                self.connection = pika.BlockingConnection(self.parameters)
                self.channel = self.connection.channel()
                self.channel.exchange_declare(self.exchange, type="topic")
                connected = True
            except Exception as e:
                log.error(e)
                log.error("Trying to reconnect in 5 seconds")
                time.sleep(5)
