#!/usr/bin/python
# -*- coding: utf-8 -*-
import requests
USER = "worldsensing"
PASS = "delHoorAifdoicseet1odNun"
SERVER = 'development.mobility.wocs3.com'
URL = 'https://%s/mb/objects' % (SERVER)

# Schema
SCHEMA = """{
    "properties": {
        "description": {
            "$ref": "#/rich_text"
        },
        "last_maintenance": {
            "$ref": "#/date"
        },
        "name": {
            "type": "string"
        },
        "profile_picture": {
            "$ref": "#/url_picture"
        },
        "test_id": {
            "$ref": "#/external_id"
        }
    },
    "type": "object"
    }"""


def insert_schemas(object_type, payload):
    url = URL + '/' + object_type + '/schema'
    request = requests.put(url, auth=(USER, PASS), data=payload)
    response = request.text
    print response


def insert_data(object_type):
    for x in [1, 3, 5]:
        payload = """{
            "name":"Vehicle Counting Point - UPDATED",
            "test_id":{
                "value":"TEST-%s"
            },
            "description":{
                "value":"<h1>MOBILITY</h1> <p>La plataforma Mobility es una herramienta que permite unificar, en un solo lugar, informaicón geo-referenciada relativa a agencias, instituciones, sistemas de terceros, datos captados por sensores, y capas de interés para la movilidad de una ciudad. Su principal objetivo es ayudar a las autoridades en la toma de decisiones operacionales o planeamiento a corto plazo para la optimización de los tiempos de respuesta y la eficiencia en la coordinación de los diferentes entes implicados.</p> <p>La plataforma de operación unificada de sistemas relacionados con la movilidad “Mobility”, permite la visualización del estado del tráfico vehicular de las principales arterias monitorizadas de la ciudad mediante el uso de “Vistas” y “Capas”, así como también de los diferentes elementos que interactúan con el tráfico, proporcionando información de vital importancia sobre tendencias y concordancia para la toma de decisiones.</p> <p>Vale la pena resaltar que mediante la correlación de información en tiempo real, la herramienta permite el análisis de datos históricos almacenados en la Base de Datos, la cual es única a cada una de las fuentes integradas para optimizar la planeación a largo plazo.</p>"
            },
            "last_maintenance":{
                "value":"2016-05-31T13:05:57Z"
            },
            "profile_picture":{
                "name":"Avatar",
                "value":"https://development.mobility.wocs3.com/mb/app/views/icons/ws-logo.png"
            }
        }""" % x
        url = URL + '/' + object_type + '/instances/core_id/robot/' + '00' + str(x)
        request = requests.put(url, auth=(USER, PASS), data=payload)
        response = request.text
        print response

insert_schemas('mb_vehiclecounting', SCHEMA)
insert_data('mb_vehiclecounting')
