# Queries
NAME = "mb"
AREA_ID = 0
ELEMENT_ID = "0"
DIRECTION = 120
LANE_ID = 1
CITY_QUERY = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20traffic_{}_ts_city_measurements_realtime%20ORDER%20BY%20time%20DESC%20limit%201".format(NAME)
AREA_INFO = "/mb/data/api/v2/sql?q=SELECT%20measurements.*%2C%20a.area_name%20FROM%20traffic_{}_ts_area_measurements_realtime%20measurements%20RIGHT%20OUTER%20JOIN%20mb_areas%20a%20on%20measurements.area_id%20%3D%20a.area_id%20WHERE%20measurements.time%20%3D%20(SELECT%20max(time)%20FROM%20traffic_{}_ts_area_measurements_realtime)and%20measurements.area_id%20={}".format(NAME, NAME, AREA_ID)
AREAS_TABLE_QUERY = "/mb/data/api/v2/sql?q=SELECT%20measurements.*%2C%20a.area_name%20FROM%20traffic_{}_ts_area_measurements_realtime%20measurements%20RIGHT%20OUTER%20JOIN%20mb_areas%20a%20on%20measurements.area_id%20%3D%20a.area_id%20WHERE%20measurements.time%20%3D%20(SELECT%20max(time)%20FROM%20traffic_{}_ts_area_measurements_realtime)".format(NAME, NAME)
RS_INFO = "/mb/data/api/v2/sql?q=SELECT%20tscem.*%2C%20a.name%20%2Ca.external_id%20FROM%20traffic_{}_ts_roadsegment_measurements_realtime%20tscem%20RIGHT%20OUTER%20JOIN%20traffic_{}_meta_roadsegment%20a%20on%20tscem.road_segment_id%20%3D%20a.core_id%20WHERE%20tscem.road_segment_id%3D%27simo%23{}%27%20ORDER%20BY%20tscem.time%20DESC%20limit%201".format(NAME, NAME, ELEMENT_ID)
DIRECTION_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20traffic_{}_ts_direction_measurements_realtime%20WHERE%20road_segment_id%20=%20%27simo%23{}%27%20AND%20direction%20=%20{}%20ORDER%20BY%20time%20DESC%20limit%201".format(NAME, ELEMENT_ID, DIRECTION)
LANE_INFO = "/mb/data/api/v2/sql?q=SELECT%20tscem.*%20FROM%20traffic_{}_ts_lane_measurements_realtime%20tscem%20WHERE%20tscem.road_segment_id%3D%27simo%23{}%27%20AND%20tscem.lane_id%3D%27{}%27%20AND%20tscem.time%20%3E%20now()%20-%20interval%20%2730%20minutes%27%20ORDER%20BY%20tscem.time%20DESC%20limit%201".format(NAME, ELEMENT_ID, LANE_ID)
LANE_LOS_INFO = "/mb/data/api/v2/sql?q=SELECT%20tscem.lane_id%2C%20tscem.los%20FROM%20traffic_mb_ts_lane_measurements_realtime_current%20tscem%20WHERE%20tscem.road_segment_id%3D%27simo%23{}%27%20ORDER%20BY%20tscem.lane_id%20ASC%2C%20tscem.time%20DESC".format(NAME, ELEMENT_ID)

# Left Menu
menu_title = "TRAFFIC"
menu_tooltip = "Traffic Package"
menu_button = '//*[@id="Traffic"]'
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"

# Private Layers
top_layers_base = '//div[contains(@class, "topLayerManager__otherLayers")]/div[1]'
top_layers_base_section = '//div[contains(@class, "topLayerManager__otherLayers")]/div[2]'
image = '//div[contains(@class,"image-wrapper")]/img'
text = '//div[contains(@class,"text-wrapper")]/span[1]/span'

phf_label = "PHF"
phf_base = top_layers_base + "/div[2]"
phf_icon_xpath = phf_base + image
phf_label_xpath = phf_base + text

mi_label = "MATCHING INDEX"
mi_base = top_layers_base + "/div[4]"
mi_icon_xpath = mi_base + image
mi_label_xpath = mi_base + text

density_label = "DENSITY / MAX. DEN."
density_base = top_layers_base + "/div[3]"
density_icon_xpath = density_base + image
density_label_xpath = density_base + text

flow_label = "FLOW RATE / CAPACITY"
flow_base = top_layers_base + "/div[1]"
flow_icon_xpath = flow_base + image
flow_label_xpath = flow_base + text

area_label = "AREA"
area_base = top_layers_base_section + "/div[2]"
area_icon_xpath = area_base + image
area_label_xpath = area_base + text

road_label = "ROAD SEGMENT"
road_base = top_layers_base_section + "/div[1]"
road_icon_xpath = road_base + image
road_label_xpath = road_base + text

timelapse_label = "LAST 24 HOURS"
timelapse_base = '//div[contains(@class,"torque__container")]/div'
timelapse_icon_xpath = timelapse_base + image
timelapse_label_xpath = timelapse_base + text + '/span[1]/span'

# Popups
timeout = "10s"
popup_header = """//*[@id="popup-generic"]/div/div[1]/div[1]/div/div/span/div"""
popup_close_button = """//*[@id="popup-generic"]/div/div[1]/div[1]/a"""
popup_area_flow_per_capacity_counter = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[1]/div/div[2]/p"""
popup_area_mi_flow_per_capacity_counter = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[1]/div/div[2]/div/p[1]"""
popup_area_flow_counter = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[2]/div/div[2]/p"""
popup_area_mi_flow_counter =                    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[2]/div/div[2]/div/p[1]"""
popup_area_phf_counter =                        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[3]/div/div[2]/p"""
popup_area_mi_phf_counter =                     """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[3]/div/div[2]/div/p[1]"""
popup_area_density_counter =                    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[4]/div/div[2]/p"""
popup_area_mi_density_counter =                 """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[4]/div/div[2]/div/p[1]"""
popup_area_density_per_max_density_counter =    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[5]/div/div[2]/p"""
popup_area_mi_density_per_max_density_counter = """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[5]/div/div[2]/div/p[1]"""
popup_area_avgspeed_counter =                   """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[6]/div/div[2]/p"""
popup_area_mi_avgspeed_counter =                """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[6]/div/div[2]/div/p[1]"""
popup_area_congestion_counter =                 """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[7]/div/div/p"""
popup_area_mi_congestion_counter =              """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[7]/div/div/div/p[1]"""
popup_area_los_counter =                        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[9]/div/div/p[1]"""

popup_element_kpis =                                """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div"""
popup_element_flow_per_capacity_counter =           """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[1]/div/div[2]/p"""
popup_element_mi_flow_per_capacity_counter =        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[1]/div/div[2]/div/p[1]"""
popup_element_flow_counter =                        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[2]/div/div[2]/p"""
popup_element_mi_flow_counter =                     """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[2]/div/div[2]/div/p[1]"""
popup_element_phf_counter =                         """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[3]/div/div[2]/p"""
popup_element_mi_phf_counter =                      """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[3]/div/div[2]/div/p[1]"""
popup_element_density_counter =                     """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[4]/div/div[2]/p"""
popup_element_mi_density_counter =                  """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[4]/div/div[2]/div/p[1]"""
popup_element_density_per_max_density_counter =     """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[5]/div/div[2]/p"""
popup_element_mi_density_per_max_density_counter =  """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[5]/div/div[2]/div/p[1]"""
popup_element_avgspeed_counter =                    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[6]/div/div[2]/p"""
popup_element_mi_avgspeed_counter =                 """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[6]/div/div[2]/div/p[1]"""
popup_element_congestion_counter =                  """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[7]/div/div/p"""
popup_element_mi_congestion_counter =               """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[7]/div/div/div/p[1]"""
popup_element_los_counter =                         """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[9]/div/div/p[1]"""
popup_element_direction_selector =                  """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[1]/div/div[2]/div/div/div[1]/button[1]"""
popup_element_lane_selector =                       """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[1]/div/div[2]/div/div/div[2]/button[1]"""

# Left Panel
title = "Traffic"
sort_selector = "sorttraficTable"

value = '/p[1]'
mi = '/p[2]'
counter_base = '//*[@id="leftside"]/div[1]'

flow_per_capacity_base = counter_base + '/a[1]/div/div[2]'
flow_per_capacity_counter = flow_per_capacity_base + value
mi_flow_per_capacity_counter = flow_per_capacity_base + mi

phf_counter_base = counter_base + '/a[2]/div/div[2]'
phf_counter = phf_counter_base + value
mi_phf_counter = phf_counter_base + mi

density_per_max_density_counter_base = counter_base + '/a[3]/div/div[2]'
density_per_max_density_counter = density_per_max_density_counter_base + value
mi_density_per_max_density_counter = density_per_max_density_counter_base + mi

mi_counter = counter_base + '/a[4]/div/div[2]' + value

congestion_base = counter_base + '/a[5]/div/div[2]'
congestion_counter = congestion_base + value
mi_congestion_counter = congestion_base + mi

los_counter = counter_base + '/a[7]/div/div/p[1]'

area_header =  """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[2]"""
flow_header =                           """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[3]"""
density_header =                        """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[4]"""
phf_header =                            """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[5]"""
matching_header =                       """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[7]"""
los_header =                            """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[8]"""
areas_table =                           """//*[@id="leftside"]/div[2]/div[2]/div[3]"""
element_in_table =                      areas_table + "/div[2]"

# Map
center_coordinates = [41.39217, 2.16488]  # TODO get from configuration
zoom = 20  # TODO get from leaflet
