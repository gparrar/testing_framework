#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# Environment

USER_TOKEN = """eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGSjg2R2NGM2pUYk5MT2NvNE52WmtVQ0lVbWZZQ3FvcXRPUWVNZmJoTmxFIn0.eyJqdGkiOiI0MjkxNjFjMi1mYzgyLTQ2MDItYTRhOS03ZjQyYjNlY2ZlMDMiLCJleHAiOjE1MTY2NDE0MDksIm5iZiI6MCwiaWF0IjoxNTE2NjQwNTA5LCJpc3MiOiJodHRwczovL2RldmVsb3BtZW50Lm1vYmlsaXR5LndvY3MzLmNvbS9hdXRoL3JlYWxtcy93b3JsZHNlbnNpbmctbW9iaWxpdHkiLCJhdWQiOiJyb2JvdCIsInN1YiI6ImNiODdkZTQwLTU2NTYtNDNiYS05Y2YxLTcyYzc3MjMzNzg3YiIsInR5cCI6IkJlYXJlciIsImF6cCI6InJvYm90IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiOTU3MzNhODctYzdlMy00NDE2LWIzZGMtN2U5ZDIyODk4NmYzIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2RldmVsb3BtZW50Lm1vYmlsaXR5LndvY3MzLmNvbS9hdXRoIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJSZWFkQVBJVXNlciIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7Im1vYmlsaXR5LXdlYi1hcHAiOnsicm9sZXMiOlsidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwicHJlZmVycmVkX3VzZXJuYW1lIjoicm9ib3QtdXNlciJ9.Ecf68DS8oT3ZNofE008ig6ufshhkE3omyKjmZnxc-8Vf8Ab_upM90KwjPvQPG0E39w_WleSMoRIxGHtLp1ZA25oWJrU36GgertQ7oklWuNMMNaY7IbkIt5u8_UvqOgVhQupqpoY4rY4Wyy7Okj7g-xk5b5rs70ONh70BoL89Le4"""

# Left Menu
menu_button = '//*[@id="Incidents"]'
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"
menu_button_id = "id:Incidents"
menu_title_path = 'xpath://span[contains(@class, "mainTitleText")]'   # TODO move to global
menu_title = "INCIDENTS"
menu_tooltip = "Incidents Insights"
title = "Incidents"

# Map
map_tile = """//*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]"""

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
top_layers_base = '//div[contains(@class, "topLayerManager__style")]'
image = '//div[contains(@class,"image-wrapper")]/img'
text = '//div[contains(@class,"text-wrapper")]/span[1]/span'

position_label = "LOCATION"
position_base = top_layers_base + "/div[1]"
position_icon_xpath =  position_base + image
position_label_xpath = position_base + text

heatmap_label = "HEATMAP"
heatmap_base = top_layers_base + "/div[2]"
heatmap_icon_xpath = heatmap_base + image
heatmap_label_xpath = heatmap_base + text

number_label =          "NUMBER"
number_base = top_layers_base + "/div[3]"
number_icon_xpath = number_base + image
number_label_xpath = number_base + text

density_label =         "DENSITY"
density_base = top_layers_base + "/div[4]"
density_icon_xpath = density_base + image
density_label_xpath = density_base + text

mi_label = "MATCHING INDEX"
mi_base = top_layers_base + "/div[5]"
mi_icon_xpath = mi_base + image
mi_label_xpath = mi_base + text

timelapse_label = "LAST 7 DAYS"
timelapse_base = top_layers_base + "/div[6]"
timelapse_icon_xpath =  timelapse_base + image
timelapse_label_xpath = timelapse_base + text

# Popups
popup_incident_title =          """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/div[2]"""
popup_incident_type =           '//*[@id="popup-generic"]//div[contains(@class, "incidenceTable__tdType")]'
popup_incident_date =           """//*[@id="incidents_table"]/div[1]/div[4]"""
popup_incident_impact =         """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/div[3]"""
popup_incident_description =    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[3]/p"""
popup_area_incidents =          """//*[@id="popup-generic"]/div/div[1]/div[2]/div/div[2]/div/div[1]/h2[2]"""
popup_area_mi =                 """//*[@id="popup-generic"]/div/div[1]/div[2]/div/div[2]/div/div[2]/div/p"""

# Left Panel
title =             "Incidents"
area_chart =        """//*[@id="leftside"]/div/div[3]/div[1]/div[2]/div/div[1]/div[1]"""
table_asc_button =  """//*[@id="leftside"]/div/div[4]/div/button[@id="ascincidences"]"""
table_desc_button = """//*[@id="leftside"]/div/div[4]/div/button[@id="descincidences"]"""
global_mi =         """//*[@id="leftside"]/div/div[3]/div[2]/div[2]/div/p"""
global_incidents =  """//*[@id="leftside"]/div/div[3]/div[2]/div[1]/h2[2]"""
incident_in_table = """//*[@id="incidents_table"]/div[1]"""
