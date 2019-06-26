#!/usr/bin/python
# -*- coding: utf-8 -*-
import csv
import json
import re
import requests

USER = "worldsensing"
PASS = "delHoorAifdoicseet1odNun"
SERVER = "development.mobility.wocs3.com"
BASE_URL = "https://%s/mb" % (SERVER)

# Object
OBJECTS = [{
    "object_type": "traffic_lights",
    "core": True
    },
    {
    "object_type": "robot_custom_panel",
    "core": True
    },
    {
    "object_type": "robot_custom_radar",
    "core": True
    }]

# Schema
SCHEMA = """{
    "properties": {
        "geometry": {
            "$ref": "#/geometry"
        },
        "name": {
            "type": "string"
        },
        "test_id": {
            "$ref": "#/external_id"
        }
    },
    "type": "object"
    }"""

# Instances
ELEMENTS = [{
    "name": "SEMAFORO 1",
    "test_id": {
    "value":"TEST-001"
    },
    "geometry": {
            "type": "Point",
            "coordinates": [
              2.174220085144043,
              41.39586980544921
            ]
    }
},
{
    "name": "SEMAFORO 2",
    "test_id": {
    "value":"TEST-002"
    },
    "geometry": {
            "type": "Point",
            "coordinates": [
              2.173147201538086,
              41.39672292284383
        ]
    }
},
{
    "name": "PANEL",
    "test_id": {
    "value":"TEST-003"
    },
    "geometry": {
            "type": "Point",
            "coordinates": [
              2.17543512582778,
              41.3966665852479
        ]
    }
},
{
    "name": "RADAR",
    "test_id": {
    "value":"TEST-004"
    },
    "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [
              2.1764838695526123,
              41.3958577329529
            ],
            [
              2.176843285560608,
              41.3955961616489
            ],
            [
              2.17803418636322,
              41.39640904133084
            ],
            [
              2.1776533126831055,
              41.39668670582355
            ],
            [
              2.1764838695526123,
              41.3958577329529
            ]
          ]
        ]
    }
}]

SHAPE_BUFFER = """{
    "geometry":{
        "type": "Buffer",
        "radius": 20
        },
    "role":"influencer",
    "tags": {"core": false, "hasActions": true}
    }"""

SHAPE_POLYGON =  """{
    "geometry": {
        "type": "Polygon",
        "coordinates": [
            [
                [
                    -0.00029772520065,
                    -0.0001871216509
                ],
                [
                    0.00025480985642,
                    -0.0001871216509
                ],
                [
                    0.00025480985642,
                    0.0002233380395
                ],
                [
                    -0.00029772520065,
                    0.0002233380395
                ],
                [
                    -0.00029772520065,
                    -0.0001871216509
                ]
            ]
        ]
    },
    "role":"influencer",
    "tags": {}
    }"""

def create_objects():
    for object in OBJECTS:
        url = "%s/objects" % (BASE_URL)
        request = requests.post(url, auth=(USER, PASS), data=json.dumps(object))
        response = request.text
        print response
        object_type = object["object_type"]
        url = "%s/objects/%s/schema" % (BASE_URL, object_type)
        request = requests.put(url, auth=(USER, PASS), data=SCHEMA)
        response = request.text
        print response

def insert_data():
    for element in ELEMENTS:
        if element["name"] == "PANEL":
            object_type = "robot_custom_panel"
        elif element["name"] == "RADAR":
            object_type = "robot_custom_radar"
        elif re.search("SEMAFORO", element["name"]):
            object_type = "traffic_lights"
        url = "%s/objects/%s/instances" % (BASE_URL, object_type)
        request = requests.post(url, auth=(USER, PASS), data=json.dumps(element))
        response = request.text
        print response

def update_data():
    for element in ELEMENTS:
        if element["name"] == "PANEL":
            object_type = "robot_custom_panel"
        elif element["name"] == "RADAR":
            object_type = "robot_custom_radar"
        elif re.search("SEMAFORO", element["name"]):
            object_type = "traffic_lights"
        external_id = element["test_id"]["value"]
        url = "%s/objects/%s/instances/external/test_id/%s" % (BASE_URL, object_type, external_id)
        request = requests.put(url, auth=(USER, PASS), data=json.dumps(element))
        response = request.text
        print response

def set_shape_definitions():
    url = "%s/influences/shapes/robot_custom_panel" % (BASE_URL)
    request = requests.put(url, auth=(USER, PASS), data=SHAPE_POLYGON)
    response = request.text
    print response
    url = "%s/influences/shapes/robot_custom_radar" % (BASE_URL)
    request = requests.put(url, auth=(USER, PASS), data=SHAPE_BUFFER)
    response = request.text
    print response
    url = "%s/influences/shapes/traffic_lights" % (BASE_URL)
    request = requests.put(url, auth=(USER, PASS), data=SHAPE_BUFFER)
    response = request.text
    print response



def delete_instances():
    for element in ELEMENTS:
        if element["name"] == "PANEL":
            object_type = "robot_custom_panel"
        elif element["name"] == "RADAR":
            object_type = "robot_custom_radar"
        elif re.search("SEMAFORO", element["name"]):
            object_type = "traffic_lights"
        external_id = element["test_id"]["value"]
        url = "%s/objects/%s/instances/external/test_id/%s" % (BASE_URL, object_type, external_id)
        request = requests.get(url, auth=(USER, PASS))
        internal_id = json.loads(request.text)["id"]
        url = "%s/objects/instances/%s" % (BASE_URL, internal_id)
        request = requests.delete(url, auth=(USER, PASS))
        response = request.text
        print response

#delete_instances()
create_objects()
set_shape_definitions()
insert_data()
