#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# Evironment
VALID_USER = "worldsensing"
VALID_PASSWORD = "worldsensing"
SCHEME = "https"
SERVER = "demo-mobility.worldsensing.com"
LANGUAGE = "en"
WORKING_URL = SCHEME + "://" + VALID_USER + ":" + VALID_PASSWORD + "@" + SERVER + "/mb/app?language=" + LANGUAGE


# Queries
ELEMENT_ID = 83
AREA_ID = 0
ELEMENT_TYPES = "Hola"
NAME = "agents"



# Left Menu
menu_button = """//*[@id="Agents"]"""
menu_title = "AGENTS"
menu_tooltip = "Agents Tracking Insights"
title = "Agents"


# Queries
TOTAL_ELEMENTS = "/mb/data/api/v2/sql?q=SELECT%20SUM(elements)%20FROM%20tracking_total_type_mview_{}".format(NAME)
ACTIVE_ELEMENTS = "/mb/data/api/v2/sql?q=SELECT%20COALESCE(SUM(elements)%2C%200)%20AS%20elements%20FROM%20tracking_active_type_mview_{}".format(NAME)
MATCHING_INDEX = "/mb/data/api/v2/sql?q=SELECT%20active_match%20as%20elements_match%20FROM%20tracking_active_global_current_matching_mview_{}".format(NAME)
AREAS_TABLE_QUERY = "/mb/data/api/v2/sql?q=SELECT%20ta.area_name%2C%20ta.area_id%2C%20ta.shape_area%2C%20ta.elementsall%2C%20ta.elements%2C%20ta.density%2C%20ta.elements_match%20as%20match%2C%20tag.shape_area%20as%20area_square%20FROM%20tracking_areas_overview_mview_{}%20ta%20INNER%20JOIN%20mb_areas%20tag%20ON%20ta.area_id%20%3D%20tag.area_id".format(NAME)
AREA_HEADER = "/mb/data/api/v2/sql?q=SELECT%20area_name%2C%20shape_area%20FROM%20tracking_areas_overview_mview_{}%20WHERE%20area_id={}".format(NAME, AREA_ID)
AREA_INFO = "/mb/data/api/v2/sql?q=SELECT%20elements%2C%20elementsall%2C%20density%2C%20elements_match%20FROM%20tracking_areas_overview_mview_{}%20WHERE%20area_id={}".format(NAME, AREA_ID)

# Private Layers
position_label =        "LOCATION"
position_icon_xpath =   """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[1]/img"""
position_label_xpath =  """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[2]/span[1]/span"""
heatmap_label =         "HEATMAP"
heatmap_icon_xpath =    """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[1]/img"""
heatmap_label_xpath =   """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[2]/span[1]/span"""
number_label =          "NUMBER"
number_icon_xpath =     """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[1]/img"""
number_label_xpath =    """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[2]/span[1]/span"""
density_label =         "DENSITY"
density_icon_xpath =    """//*[@id="app"]/div/div/div[3]/div[2]/div[4]/div[1]/img"""
density_label_xpath =   """//*[@id="app"]/div/div/div[3]/div[2]/div[4]/div[2]/span[1]/span"""
mi_label =              "MATCHING INDEX"
private_layers =        """//*[@id="app"]/div/div/div[3]/div[2]"""
mi_icon_xpath =         """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div[1]/img"""
mi_label_xpath =        """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div[2]/span[1]/span"""
timelapse_label =       "LAST 24 HOURS"
timelapse_icon_xpath =  """//*[@id="app"]/div/div/div[3]/div[2]/div[6]/div/div[1]/img"""
timelapse_label_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[6]/div/div[2]/span[1]/span"""


# Popups
popup_header = """//*[@id="popup-generic"]/div/div[1]/div[1]/div/div/span"""
popup_close_button = """//*[@id="popup-generic"]/div/div[1]/div[1]/a"""
popup_area_total = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[2]/div[1]/div/p[1]"""
popup_area_active = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[2]/div[2]/div/p[1]"""
popup_area_density = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[2]/div[3]/div/p[1]"""
popup_area_mi = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[2]/div[4]/div/p[1]"""

# Left Menu
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"

# Left Panel
area_chart = """//*[@id="leftside"]/div/div[3]/div[1]/div[2]/div/div[3]"""
table_asc_button = """//*[@id="leftside"]/div/div[4]/div/button[@id="asclocations"]"""
table_desc_button = """//*[@id="leftside"]/div/div[4]/div/button[@id="desclocations"]"""
global_total = """//*[@id="leftside"]/div/div[2]/div[1]/div/div/p"""
global_active = """//*[@id="leftside"]/div/div[2]/div[2]/div/div/p"""
global_mi = """//*[@id="leftside"]/div/div[2]/div[3]/div/div/p"""
areas_table = """//*[@id="leftside"]/div/div[5]/div[2]/div"""
element_in_table = areas_table + "/div[2]"
sort_selector = "sortlocations"

# Map
map_tile = """//*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]"""
