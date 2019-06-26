#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import division
import time

def round_big_number(number):
    data = ""
    if (number/1000 % 1) == 0.0:
        data = str(int(round(number / 1000)))
    else:
        data = str(round(number / 1000,1))
    return data

def round_number(number):
    data = ""
    if number > 1:
        data = "{:,}".format(int(round(number)))
    elif number < 1:
        data = "{:,}".format(round(number, 2))
    return data

def convert_values(response):
    data = response
    for item in data:
        for key, value in item.iteritems():
            # TODO refactor to if with else
            if value is None or value == 0:
                item[key] = 0
                continue
            if isinstance(value, unicode) or isinstance(value, list):
                continue
            if key == "levelofservice":
                if value == "green":
                    item[key] = "good"
                elif value == "yellow":
                    item[key] = "medium"
                elif value == "red":
                    item[key] = "bad"
                elif value == "black":
                    item[key] = "unknown"
                continue
            if key == "current_elapsed_time" or key == "expected_elapsed_time":
                date = time.strftime("%-Hh %-Mm %-Ss", time.gmtime(value))
                item[key] = date
                continue
            item[key] = round_number(value)
    return data

def prepare_los_response(response, kpi):
    value = 0
    total_count = float()
    for i in response:
        total_count += i["count"]
    for i in response:
        if i["levelofservice"] == kpi:
            value = i["count"] * 100 / total_count
    return round_number(value)

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
    if criteria == 'speed':
        data = sorted(data, key=lambda k: k["current_speed"], reverse=reverse)
        kpi = "current_speed"
    elif criteria == 'name':
        data = sorted(data, key=lambda k: (k["name_from"], k["name_to"]), reverse=reverse)
        kpi = "name_from"
    elif criteria == 'time':
        data = sorted(data, key=lambda k: k["current_elapsed_time"], reverse=reverse)
        kpi = "current_elapsed_time"
    elif criteria == 'speed_range':
        data = sorted(data, key=lambda k: k["levelofservice"], reverse=reverse)
        kpi = "levelofservice"
    elif criteria == 'matching':
        data = sorted(data, key=lambda k: k["speed_match"], reverse=reverse)
        kpi = "speed_match"
    return data, kpi

def prepare_routes_table_response(response, criteria, order):
    kpi_list = []
    data, kpi = order_response(response, criteria, order)
    data_converted = convert_values(data)
    for item in data_converted:
        value = item[kpi]
        kpi_list.append(value)
    return kpi_list
