#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# Left Menu
menu_button = '//*[@id="Bitcarrier"]'
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"
menu_title = "TRAVEL TIME"
menu_tooltip = "Travel Time Package"
title = "Travel Time"

# Map
element_coordinates = "41.40916, 2.20404"
center_coordinates = [41.40916, 2.20404]
zoom = 18  # Zoom does not match other packages' zoom

# Queries
TID_ROUTE = 750
TID_LINK = 1000898
CITY_AVG_SPEED = "/mb/data/api/v2/sql?q=select%20avg(speed)%20from%20df_bctraveltimes_links_view;"
CITY_LOS = "/mb/data/api/v2/sql?q=SELECT%20levelofservice,%20count(*)%20FROM%20df_bctraveltimes_links_view%20group%20by%20levelofservice;"
CITY_MI = "/mb/data/api/v2/sql?q=SELECT%20avg(speed_match)%20as%20speed_match%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20type%3D1;"
ROUTES_TABLE_QUERY = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_traveltimes_overview_view;"
SINGLE_ROUTE_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20tid%3D{}".format(TID_ROUTE)
SINGLE_LINK_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_bctraveltimes_overview_mview%20WHERE%20tid%3D{}".format(TID_ROUTE)

# Private Layers
top_layers_base = '//div[contains(@class, "topLayerManager__style")]'
image = '//div[contains(@class,"image-wrapper")]/img'
text = '//div[contains(@class,"text-wrapper")]/span[1]/span'

abs_speed_label = "ABSOLUTE SPEED"
abs_speed_base = top_layers_base + "/div[1]"
abs_speed_icon_xpath = abs_speed_base + image
abs_speed_label_xpath = abs_speed_base + text

speed_range_label = "SPEED RANGE"
speed_range_base = top_layers_base + "/div[2]"
speed_range_icon_xpath = speed_range_base + image
speed_range_label_xpath = speed_range_base + text

mi_label = "MATCHING INDEX"
mi_base = top_layers_base + "/div[3]"
mi_icon_xpath = mi_base + image
mi_label_xpath = mi_base + text

# Popups
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

# Left Panel
main_routes_base = '//div[contains(@class,"leftSideTrafficFlow__scroll")]/div[5]'
average_speed = '//*[@id="container"]/div[2]/div/div/p/span'
base_los = '//*[@id="current_speed_range_legend"]'
bad_los = base_los + '/div[1]/span'
medium_los = base_los + '/div[2]/span'
good_los = base_los + '/div[3]/span'
unknown_los = base_los + '/div[4]/span'
areas_table = """//*[@id="leftside"]/div/div[5]"""
matching_index = """//*[@id="container"]/div[2]/div/p/span[1]"""

sort_selector = "sortroutes"
table_desc_button = "descroutes"
table_asc_button = "ascroutes"

routes_table = """//*[@id="leftside"]/div/div[5]"""
table_item = routes_table + '/div[1]'
element_in_table = areas_table + '/div[1]'
