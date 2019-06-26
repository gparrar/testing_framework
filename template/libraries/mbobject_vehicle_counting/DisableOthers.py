import json
import thriftpy
import os
from pika_thriftpy_client import TPikaTransport
from thriftpy.protocol.binary import TBinaryProtocol
from thriftpy.thrift import TClient
thrift_file_path = os.path.join(os.path.dirname(__file__), 'data.thrift')
thriftpy.load(thrift_file_path, module_name="vehicle_counting_thrift")
from vehicle_counting_thrift import DataService


class DisableOthers:

    QUEUE = "vehiclecounting.mb.robot"
    host = "localhost"
    port = 5672 # Rabbit's default

    def __init__(self, host=None, port=None):
        self.host = host or self.host
        self.port = port or self.port
        url = "amqp://{}:{}/".format(self.host, self.port)
        self.client = self.initQueueConnection(self.QUEUE, host_url=url)

    def disable_others(self, source, ids_json):
        self.ids = json.loads(ids_json)
        self.client.disableOthers(source, self.ids)

    def initQueueConnection(self, queue, host_url="amqp://mbrabbitmq/"):
        if "?" in host_url:
            host_url += "&heartbeat_interval=0"
        else:
            host_url += "?heartbeat_interval=0"
        print host_url
        protocol = TBinaryProtocol(TPikaTransport(host_url, "data_msgs", queue))
        client = TClient(DataService, protocol)
        return client
