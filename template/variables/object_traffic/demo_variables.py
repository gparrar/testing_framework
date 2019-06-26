# Evironment
VALID_USER = "worldsensing"
VALID_PASSWORD = "worldsensing"
SCHEME = "https"
SERVER = "demo-mobility.worldsensing.com"
LANGUAGE = "en"
WORKING_URL = SCHEME + "://" + VALID_USER + ":" + VALID_PASSWORD + "@" + SERVER + "/mb/app?language=" + LANGUAGE

# Queries
NAME = "mb"
AREA_ID = 0
ELEMENT_ID = 0
DIRECTION = 1
LANE_ID = 1
CITY_QUERY = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20traffic_{}_ts_city_measurements_realtime%20ORDER%20BY%20time%20DESC%20limit%201".format(NAME)
AREA_INFO = "/mb/data/api/v2/sql?q=SELECT%20measurements.*%2C%20a.area_name%20FROM%20traffic_{}_ts_area_measurements_realtime%20RIGHT%20OUTER%20JOIN%20mb_areas%20a%20on%20measurements.area_id%20%3D%20a.area_id%20WHERE%20measurements.time%20%3D%20(SELECT%20max(time)%20FROM%20traffic_{}_ts_area_measurements_realtime)and%20measurements.area_id%20={}".format(NAME, NAME, AREA_ID)
AREAS_TABLE_QUERY = "/mb/data/api/v2/sql?q=SELECT%20measurements.*%2C%20a.area_name%20FROM%20traffic_{}_ts_area_measurements_realtime%20measurements%20RIGHT%20OUTER%20JOIN%20mb_areas%20a%20on%20measurements.area_id%20%3D%20a.area_id%20WHERE%20measurements.time%20%3D%20(SELECT%20max(time)%20FROM%20traffic_{}_ts_area_measurements_realtime)".format(NAME, NAME)
RS_INFO = "/mb/data/api/v2/sql?q=SELECT%20tscem.*%2C%20a.name%20%2Ca.external_id%20FROM%20traffic_{}_ts_roadsegment_measurements_realtime%20tscem%20RIGHT%20OUTER%20JOIN%20traffic_{}_meta_roadsegment%20a%20on%20tscem.road_segment_id%20%3D%20a.core_id%20WHERE%20tscem.road_segment_id%3D%27simo%23{}%27%20ORDER%20BY%20tscem.time%20DESC%20limit%201".format(NAME, NAME, ELEMENT_ID)
DIRECTION_INFO = "/mb/data/api/v2/sql?q=SELECT%20*%20FROM%20traffic_{}_ts_direction_measurements_realtime%20WHERE%20road_segment_id%20=%20%27simo%23{}%27%20AND%20direction%20=%20{}%20ORDER%20BY%20time%20DESC%20limit%201".format(NAME, ELEMENT_ID, DIRECTION)
LANE_INFO = "/mb/data/api/v2/sql?q=SELECT%20tscem.lane_id%2C%20tscem.los%20FROM%20traffic_{}_ts_lane_measurements_realtime_current%20tscem%20WHERE%20tscem.road_segment_id%3D{}20ORDER%20BY%20tscem.lane_id%20ASC%2C%20tscem.time%20DESC".format(NAME, ELEMENT_ID, LANE_ID)

# Left Menu
menu_title = "TRAFFIC"
menu_tooltip = "Traffic Insights"
menu_button = """//*[@id="Traffic"]"""
icon_xpath = menu_button + "/div[1]/img"
label_xpath = menu_button + "/div[2]"

# Private Layers
timelapse_label =       "LAST 24 HOURS"
timelapse_icon_xpath =  """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div/div[1]/img"""
timelapse_label_xpath = """//*[@id="app"]/div/div/div[3]/div[2]/div[5]/div/div[2]/span[1]/span"""
phf_label =             "PHF"
phf_icon_xpath =        """//*[@id="app"]/div/div/div[3]/div[2]/div[4]/div[1]/img"""
phf_label_xpath =       """//*[@id="app"]/div/div/div[3]/div[2]/div[4]/div[2]/span[1]/span"""
mi_label =              "MATCHING INDEX"
mi_icon_xpath =         """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[1]/img"""
mi_label_xpath =        """//*[@id="app"]/div/div/div[3]/div[2]/div[3]/div[2]/span[1]/span"""
density_label =         "DENSITY / MAX. DEN."
density_icon_xpath =    """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[1]/img"""
density_label_xpath =   """//*[@id="app"]/div/div/div[3]/div[2]/div[2]/div[2]/span[1]/span"""
flow_label =            "FLOW RATE / CAPACITY"
flow_icon_xpath =       """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[1]/img"""
flow_label_xpath =      """//*[@id="app"]/div/div/div[3]/div[2]/div[1]/div[2]/span[1]/span"""
area_label =            "AREA"
area_icon_xpath =       """//*[@id="app"]/div/div/div[3]/div[1]/div[2]/div[1]/img"""
area_label_xpath =      """//*[@id="app"]/div/div/div[3]/div[1]/div[2]/div[2]/span[1]/span"""
road_label =            "ROAD SEGMENT"
road_icon_xpath =       """//*[@id="app"]/div/div/div[3]/div[1]/div[1]/div[1]/img"""
road_label_xpath =      """//*[@id="app"]/div/div/div[3]/div[1]/div[1]/div[2]/span[1]/span"""

# Popups
timeout = "10s"
popup_header = """//*[@id="popup-generic"]/div/div[1]/div[1]/div/div/span"""
popup_close_button = """//*[@id="popup-generic"]/div/div[1]/div[1]/a"""
popup_area_flow_counter =                       """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[1]/div/div[2]/p"""
popup_area_mi_flow_counter =                    """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[1]/div/div[2]/div/p[1]"""
popup_area_flow_per_capacity_counter =          """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[2]/div/div[2]/p"""
popup_area_mi_flow_per_capacity_counter =       """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[2]/div/div[2]/div/p[1]"""
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
popup_area_los_counter =                        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div/a[8]/div/div/p[1]"""

popup_element_kpis =                                """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div"""
popup_element_flow_counter =                        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[1]/div/div[2]/p"""
popup_element_mi_flow_counter =                     """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[1]/div/div[2]/div/p[1]"""
popup_element_flow_per_capacity_counter =           """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[2]/div/div[2]/p"""
popup_element_mi_flow_per_capacity_counter =        """//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div[2]/div/a[2]/div/div[2]/div/p[1]"""
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
flow_per_capacity_counter =             """//*[@id="leftside"]/div[1]/a[1]/div/div[2]/p[1]/span"""
mi_flow_per_capacity_counter =          """//*[@id="leftside"]/div[1]/a[1]/div/div[2]/p[2]"""
mi_counter =                            """//*[@id="leftside"]/div[1]/a[2]/div/div[2]/p[1]"""
density_per_max_density_counter =       """//*[@id="leftside"]/div[1]/a[3]/div/div[2]/p[1]/span"""
mi_density_per_max_density_counter =    """//*[@id="leftside"]/div[1]/a[3]/div/div[2]/p[2]"""
congestion_counter =                    """//*[@id="leftside"]/div[1]/a[4]/div/div[2]/p[1]/span"""
mi_congestion_counter =                 """//*[@id="leftside"]/div[1]/a[4]/div/div[2]/p[2]"""
phf_counter =                           """//*[@id="leftside"]/div[1]/a[5]/div/div[2]/p[1]/span"""
mi_phf_counter =                        """//*[@id="leftside"]/div[1]/a[5]/div/div[2]/p[2]"""
los_counter =                           """//*[@id="leftside"]/div[1]/a[6]/div/div/p[1]"""
area_header =                           """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[2]"""
flow_header =                           """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[3]"""
density_header =                        """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[4]"""
phf_header =                            """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[5]"""
matching_header =                       """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[7]"""
los_header =                            """//*[@id="leftside"]/div[2]/div[2]/div[1]/div[8]"""
areas_table =                           """//*[@id="leftside"]/div[2]/div[2]/div[3]"""
element_in_table =                      areas_table + "/div[2]"

# Map
element_coordinates = "41.39217, 2.16488"
zoom = 20
