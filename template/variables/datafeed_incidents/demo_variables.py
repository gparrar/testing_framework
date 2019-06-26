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
INCIDENT_ID = 166
AREA_ID = 4
INCIDENT_TYPES = "/mb/data/api/v2/sql?q=SELECT%20name%20FROM%20df_incidences_types"
CURRENT_INCIDENTS = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_incidences_count_open_mview"
CURRENT_MI = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_incidences_open_global_current_matching_mview"
INCIDENTS_TABLE = "/mb/data/api/v2/sql?q=SELECT%20i.title%2C%20t.name%2C%20i.impact%2C%20i.start_time%2C%20i.type%20%20FROM%20df_incidences_open_mview%20i%20INNER%20JOIN%20df_incidences_types%20t%20ON%20i.type%20%3D%20t.id"
SPECIFIC_INCIDENT = "/mb/data/api/v2/sql?q=SELECT%20i.*%2C%20t.name%20FROM%20df_incidences_open_mview%20i%20INNER%20JOIN%20df_incidences_types%20t%20ON%20i.type%20%3D%20t.id%20WHERE%20incidence_id%3D{}".format(INCIDENT_ID)
SPECIFIC_AREA = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_incidences_count_open_areas_mview%20WHERE%20area_id%3D{}".format(AREA_ID)
AREA_NAME = "/mb/data/api/v2/sql?q=SELECT%20geom.area_name%2C%20inc.*%20FROM%20df_incidences_count_open_areas_mview%20inc%20%0A%20%20%20%20%20%20%20%20%20%20INNER%20JOIN%20df_incidences_areas_geom%20geom%20ON%20inc.area_id%20%3D%20geom.area_id%20WHERE%20inc.area_id%3D{}".format(AREA_ID)
AREA_MI = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20df_incidences_open_areas_current_matching_mview%20WHERE%20area_id%3D{}".format(AREA_ID)

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
mi_icon_xpath =         """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div[1]/img"""
mi_label_xpath =        """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div[2]/span[1]/span"""
timelapse_label =       "Last. 24 h"
timelapse_icon_xpath =  """//*[@id="app"]/div/div/div[3]/div[2]/div[6]/div/div[1]/img"""
timelapse_label_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[6]/div/div[2]/span[1]/span"""

# Popups
popup_header = """//*[@id="popup-generic"]/div/div[1]/div[1]/div/div/span"""
popup_body = """//*[@id="popup-generic"]/div/div[1]/div[2]"""
popup_close_button = """//*[@id="popup-generic"]/div/div[1]/div[1]/a[2]"""
popup_incident_title = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/div[2]"""
popup_incident_type = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/div[2]"""
popup_incident_date = """//*[@id="incidents_table"]/div[1]/div[4]"""
popup_incident_impact = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/div[3]"""
popup_incident_description = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[3]/p"""
popup_area_incidents = """//*[@id="popup-generic"]/div/div[1]/div[2]/div/div[2]/div/div[1]/h2[2]"""
popup_area_mi = """//*[@id="popup-generic"]/div/div[1]/div[2]/div/div[2]/div/div[2]/div/p"""


# Left Menu
menu_title = "INCIDENTS"
menu_tooltip = "Incidents Insights"
menu_button = """//*[@id="Incidents"]"""
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"

# Left Panel
title = "Incidents"
area_chart = """//*[@id="leftside"]/div/div[3]/div[1]/div[2]/div/div[1]/div[1]"""
table_asc_button = """//*[@id="leftside"]/div/div[4]/div/button[@id="ascincidences"]"""
table_desc_button = """//*[@id="leftside"]/div/div[4]/div/button[@id="descincidences"]"""
global_mi = """//*[@id="leftside"]/div/div[3]/div[2]/div[2]/div/p"""
global_incidents = """//*[@id="leftside"]/div/div[3]/div[2]/div[1]/h2[2]"""
incident_in_table = """//*[@id="incidents_table"]/div[1]"""


# Map
map_tile = """//*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]"""
