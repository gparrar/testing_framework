#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import division
import time

# Response Example
# response = [{
#     'impact': 4,
#     'area_id': None,
#     'the_geom_webmercator': '0101000020110F0000D742DC0E67C35EC1AD0AC859D0702041',
#     'description': '5',
#     'title': '5',
#     'the_geom': '0101000020E610000042F2FFFF671C52C0615C1835BE551340',
#     'start_time': '2017-12-07T10:39:15Z',
#     'cartodb_id': 166,
#     'incidence_id': 166,
#     'name': 'Accidente de Tr\xe1nsito con heridos',
#     'source': [5],
#     'end_time': None,
#     'type': 68,
#     'public': True,
#     'comments': None
# }]

def round_big_number(number):
    result = ""
    if (number/1000 % 1) == 0.0:
        result = str(int(round(number / 1000)))
    else:
        result = str(round(number / 1000, 1))
    return result

def round_number(number):
    result = ""
    if number > 1:
        result = "{:,}".format(int(round(number)))
    elif number < 1:
        result = "{:,}".format(round(number, 2))
    return result

def convert_values(response):
    data = response
    for item in data:
        for key, value in item.iteritems():
            if value is None or value == 0:
                item[key] = 0
                continue
            if key == "name":
                item[key] = value.upper()
                continue
            if key == "start_time":
                date = time.strftime("%-d\n%b'%y\n%H:%M:%S", time.strptime(value, "%Y-%m-%dT%H:%M:%SZ")).upper()
                item[key] = unicode(date)
                continue
            if key == "incidences_match":
                item[key] = round_number(value) + '%'
                continue
            if key == "impact":
                item[key] = int(value)
                continue
            if isinstance(value, list) or isinstance(value, str) or isinstance(value, bool):
                continue
            if isinstance(value, unicode):
                continue
            item[key] = round_number(value)
    return data

def prepare_response(response, kpi):
    data = convert_values(response)
    value = data[0][kpi]
    return value

def order_response(response, criteria, order):
    data = response
    kpi_list = []
    kpi = None
    if order == 'asc':
        reverse = False
    elif order == 'desc':
        reverse = True
    if criteria == 'name':
        data = sorted(data, key=lambda k: k["title"], reverse=reverse)
        kpi = "title"
    elif criteria == 'type':
        data = sorted(data, key=lambda k: k["name"], reverse=reverse)
        kpi = "name"
    elif criteria == 'impact':
        data = sorted(data, key=lambda k: k["impact"], reverse=reverse)
        kpi = "impact"
    elif criteria == 'date':
        data = sorted(data, key=lambda k: k["start_time"], reverse=reverse)
        kpi = "start_time"
    print kpi
    return data, kpi

def prepare_incidents_table_response(response, criteria, order):
    kpi_list = []
    data, kpi = order_response(response, criteria, order)
    data_converted = convert_values(data)
    for item in data_converted:
        print item, kpi
        value = item[kpi]
        kpi_list.append(value)
    return kpi_list
