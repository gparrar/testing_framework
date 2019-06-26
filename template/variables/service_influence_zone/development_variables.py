import os
import sys
sys.path.append(os.path.join(os.environ["ROBOT_DIR"], "variables"))
from global_paths import popup_header

# Environment
#VALID_USER = "admin"
#VALID_PASSWORD = "CidHafnisearwybnetcytval"
VALID_USER = "worldsensing"
VALID_PASSWORD = "delHoorAifdoicseet1odNun"

SCHEME = "https"
SERVER = "development.mobility.wocs3.com"
LANGUAGE = "en"
WORKING_URL = SCHEME + "://" + SERVER + "/mb/app?language=" + LANGUAGE

# Ciutadella Parc
# https://www.google.es/maps/place/41%C2%B023'13.3%22N+2%C2%B011'19.0%22E/@41.3870503,2.1798268,15z/data=!3m1!4b1!4m6!3m5!1s0x0:0x0!7e2!8m2!3d41.3870351!4d2.1886033?hl=en
LONGITUDE = "41.387035"
LATITUDE = "2.188603"

# Internal Paths
resources_path = "resources/service_influence_zone"

# Ids and XPaths
iz_button = '//div[contains(@class,"InfluencesAside__button")]'
iz_panel = '//div[contains(@class,"InfluencesPanel")]'
iz_panel_header = '//div[contains(@class,"InfluencesPanelHeader")]'  # NOTE the header is used for collapsing

slider_xpath =                  """//*[@id="core-map"]/div[2]/div/div/div[3]/div[1]/input"""
slider_radius_xpath =           """//*[@id="core-map"]/div[2]/div/div/div[3]/div[1]/div[3]"""
actions_filter_xpath =          """"""
influencer_filter_xpath =       """//*[@id="core-map"]/div[2]/div/div/div[3]/div[2]/div[2]/div[1]"""
influenced_filter_xpath =       """//*[@id="core-map"]/div[2]/div/div/div[3]/div[2]/div[2]/div[2]"""
search_bar_xpath =              """//*[@id="core-map"]/div[2]/div/div/div[3]/div[2]/div[3]/input"""

tracking_element_xpath =        """//*[@id="core-map"]/div[2]/div/div/div[3]/div[3]/div/div"""
first_iz_element_xpath =        """//*[@id="core-map"]/div[2]/div/div/div[3]/div[3]/div[2]/div"""
second_iz_element_xpath =       """//*[@id="core-map"]/div[2]/div/div/div[3]/div[3]/div[3]/div"""

iz_instance_list = '//div[contains(@class,"aside")]//div[contains(@class,"Instance__InfluencesInstanceList__scroller")]'
iz_instance_name = iz_instance_list + '/div[{}]//div[contains(@class,"bottom")]'
iz_instance_distance = iz_instance_list + '/div[{}]//div[contains(@class,"top")]'

first_element_name =            "Special Agent 42"  # TODO not existing now
first_element_name_xpath  = iz_instance_name.format(1)
first_element_distance =        "36 m."
first_element_distance_xpath =  iz_instance_distance.format(1)

second_element_name =            "IZ ENV INSTANCE 1"
second_element_name_xpath = iz_instance_name.format(2)
second_element_distance =       "144 m."
second_element_distance_xpath = iz_instance_distance.format(2)

third_element_name =            "IZ ENV INSTANCE 2"
third_element_name_xpath =      iz_instance_name.format(3)
third_element_distance =        "215 m."
third_element_distance_xpath =  iz_instance_distance.format(3)

fourth_element_name =            "Police Agent 25" # TODO dynamic, not static
fourth_element_name_xpath  = iz_instance_name.format(4)
fourth_element_distance =        "36 m."
fourth_element_distance_xpath =  iz_instance_distance.format(4)

display_influence_zones_xpath = """//*[@id="influences"]/div/div/div[3]/div[4]/div[1]/div"""

scroller = iz_instance_list
