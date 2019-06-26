#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import division

# Response Example
# response = [{
#     'density_per_max_density_min': 0,
#     'server_time': '2018-01-23T10:04:27Z',
#     'mi_density': 114.406825215685,
#     'mi': 114.406825215685,
#     'number_vehicles': 6851,
#     'period_inverted': 0,
#     'avgspeed_min': 0,
#     'flow_per_capacity_max': 9.83333333333333,
#     'flow_per_capacity': 2.63318452929365,
#     'avg_length_m': 3,
#     'density_per_max_density': 0.000821871693959164,
#     'capacity': 78053.7777408001,
#     'class_count': [360, 720, 1080, 1440, 1800, 2160, 2520],
#     'density_min': 0, 'los': 'F', 'mi_flow_per_capacity': 118.085795983321,
#     'density_per_max_density_max': 9.83333333333333,
#     'mi_los': 121.006118102087,
#     'mi_peak_hour_factor': 125.105335644069,
#     'avgspeed_max': 240,
#     'mi_flow': 127.092167342062,
#     'density_max': 3000,
#     'mi_congested': 126.581652226287,
#     'occupancy_percentage': 95,
#     'mi_class_count': 103.393962122661,
#     'avg_speed_kmh': 5,
#     'avg_headway_ms': None,
#     'integration_period_s': 120,
#     'congested': 100,
#     'security_separation_km': 0.00446677695064792,
#     'class_id': [1, 2, 3, 4, 5, 6, 7],
#     'density': 41106, 'flow': 205530,
#     'mi_avg_speed_kmh': 74.7412817487399,
#     'peak_hour_factor': 0.988137344276942,
#     'flow_per_capacity_min': 0,
#     'max_density': 50015106.1316907,
#     'time': '2018-01-23T06:59:42Z',
#     'mi_density_per_max_density': 118.085795983321
# }]


def round_big_number(number):
    result = ""
    if (number/1000 % 1) == 0.0:
        result = str(int(round(number / 1000)))
    else:
        result = str(round(number / 1000,1))
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
            if isinstance(value, list):
                continue
            if isinstance(value, unicode) or isinstance(value, str):
                item[key] = value.upper()
                continue
            if value >= 1000:
                item[key] = round_big_number(value) + "K"
                continue
            if key.startswith("mi") or value == "congested":
                item[key] = round_number(value) + "%"
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
    if order == "asc":
        reverse = False
    elif order == "desc":
        reverse = True
    if criteria == "area":
        data = sorted(data, key=lambda k: k["area_name"], reverse=reverse)
        kpi = "area_name"
    elif criteria == "flow":
        data = sorted(data, key=lambda k: k["flow_per_capacity"], reverse=reverse)
        kpi = "flow_per_capacity"
    elif criteria == "density":
        data = sorted(data, key=lambda k: k["density_per_max_density"], reverse=reverse)
        kpi = "density_per_max_density"
    elif criteria == "phf":
        data = sorted(data, key=lambda k: k["peak_hour_factor"], reverse=reverse)
        kpi = "peak_hour_factor"
    elif criteria == "class":
        data = sorted(data, key=lambda k: k["flow_per_capacity"], reverse=reverse)
        kpi = "flow_per_capacity"
    elif criteria == "matching":
        data = sorted(data, key=lambda k: k["mi"], reverse=reverse)
        kpi = "mi"
    elif criteria == "los":
        data = sorted(data, key=lambda k: k["los"], reverse=reverse)
        kpi = "los"
    return data, kpi

def prepare_areas_table_response(response, criteria, order):
    kpi_list = []
    data, kpi = order_response(response, criteria, order)
    data_converted = convert_values(data)
    for item in data_converted:
        value = item[kpi]
        kpi_list.append(value)
    return kpi_list
