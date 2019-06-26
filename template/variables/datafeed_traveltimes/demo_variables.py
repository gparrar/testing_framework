#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# Environment
VALID_USER = "worldsensing"
VALID_PASSWORD = "worldsensing"
SCHEME = "https"
SERVER = "demo-mobility.worldsensing.com"
LANGUAGE = "en"
WORKING_URL = SCHEME + "://" + VALID_USER + ":" + VALID_PASSWORD + "@" + SERVER + "/mb/app?language=" + LANGUAGE

# Queries
TID_ROUTE = 750
TID_LINK = 1000899

# Private Layers
speed_label = "ABSOLUTE SPEED"
speed_range_label = "SPEED RANGE"
mi_label = "MATCHING INDEX"

# Left Menu
menu_button = """//*[@id="Bitcarrier"]"""
menu_title = "TRAVEL TIME BITCARRIER"
menu_tooltip = "Travel Time Insights"
title = "Travel Time Bitcarrier"

# Map
element_coordinates = "41.40916, 2.20404"
zoom = 18


# Queries
CITY_AVG_SPEED = "/mb/data/api/v2/sql?q=select%20avg(speed)%20from%20df_bctraveltimes_links_view;"
CITY_LOS = "/mb/data/api/v2/sql?q=SELECT%20levelofservice,%20count(*)%20FROM%20df_bctraveltimes_links_view%20group%20by%20levelofservice;"
CITY_MI = "/mb/data/api/v2/sql?q=SELECT%20avg(speed_match)%20as%20speed_match%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20type%3D1;"
ROUTES_TABLE_QUERY = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_traveltimes_overview_view;"
SINGLE_ROUTE_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20tid%3D{}".format(TID_ROUTE)
SINGLE_LINK_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20tid%3D{}".format(TID_ROUTE)

# Private Layers
speed_icon_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[1]/img"""
speed_label_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[2]/span[1]"""
speed_range_icon_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[1]/img"""
speed_range_label_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[2]/span[1]"""
mi_icon_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[1]/img"""
mi_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[2]/span[1]/span"""

# Popups
popup_header = """//*[@id="popup-generic"]/div/div[1]/div[1]/div/div/span"""
popup_close_button = """//*[@id="popup-generic"]/div/div[1]/div[1]/a"""

popup_route_average_speed = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[2]/div[1]/div/p/span"""
popup_route_expected_time = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[3]/div/p[2]"""
popup_route_real_time = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[3]/div/p[4]"""
popup_route_los = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[4]/div/div[1]/span"""
popup_route_mi = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[5]/div/p/span[1]"""


popup_link_kpis = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div"""
popup_link_average_speed = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[2]/div[1]/div/p/span"""
popup_link_expected_time = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[3]/div/p[2]"""
popup_link_real_time = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[3]/div/p[4]"""
popup_link_los = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[4]/div/div[1]/span"""
popup_link_mi = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[5]/div/p/span[1]"""


# Left Menu
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"

# Left Panel
average_speed = """//*[@id="container"]/div[2]/div/div/p/span"""
bad_los = """//*[@id="current_speed_range_legend"]/div[1]/span"""
medium_los = """//*[@id="current_speed_range_legend"]/div[2]/span"""
good_los = """//*[@id="current_speed_range_legend"]/div[3]/span"""
unknown_los = """//*[@id="current_speed_range_legend"]/div[4]/span"""
areas_table = """//*[@id="leftside"]/div/div[5]"""
matching_index = """//*[@id="container"]/div[2]/div/p/span[1]"""

sort_selector = "sortroutes"
table_desc_button = "descroutes"
table_asc_button = "ascroutes"
routes_table = """//*[@id="leftside"]/div/div[5]"""
table_item = """//*[@id="leftside"]/div/div[5]/div[1]"""
element_in_table = areas_table + "/div[1]"
