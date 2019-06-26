#!/usr/bin/python
# -*- coding: utf-8 -*-


def prepare_response(response, kpi):
    result = response
    for item in result:
        print item
        for key, value in item.iteritems():
            if value is None or value == 0:
                item[key] = 0
                continue
            if isinstance(value, unicode) or isinstance(value, list):
                continue
            if key == "density":
                item[key] = round_dens_number(value)
                continue
            item[key] = round_number(value)
    return item[kpi]


def round_dens_number(number):
    result = "{:,}".format(round(number, 2))
    return result

def round_number(number):
    result = "{:,}".format(int(round(number)))
    return result

def prepare_areas_table_response(response, criteria, order):
    result = response
    kpi_list = []
    kpi = None
    if order == 'asc':
        reverse = False
    elif order == 'desc':
        reverse = True
    if criteria == 'area':
        result = sorted(result, key=lambda k: k["area_name"], reverse=reverse)
        kpi = "area_name"
    elif criteria == 'total':
        result = sorted(result, key=lambda k: k["elementsall"], reverse=reverse)
        kpi = "elementsall"
    elif criteria == 'active':
        result = sorted(result, key=lambda k: k["elements"], reverse=reverse)
        kpi = "elements"
    elif criteria == 'density':
        result = sorted(result, key=lambda k: k["density"], reverse=reverse)
        kpi = "density"
    elif criteria == 'matching':
        result = sorted(result, key=lambda k: k["match"], reverse=reverse)
        kpi = "match"
    for item in result:
        for key, value in item.iteritems():
            if value is None:
                item[key] = 0
                continue
            if isinstance(value, unicode):
                item[key] = value.upper()
                continue
            elif isinstance(value, list):
                continue
            if key == "density":
                item[key] = round_dens_number(value)
                continue
            item[key] = round_number(value)
        kpi_list.append(item[kpi])
    return kpi_list
