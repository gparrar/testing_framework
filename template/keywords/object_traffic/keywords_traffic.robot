*** Settings ***
Documentation     A resource file containing "Traffic Object, SQL API" specific keywords.
Library                         HttpLibrary.HTTP
Library                         Collections
Library                         DatabaseLibrary

*** Keywords ***
Get Table Data Value From SQL API
    [Arguments]                             ${table}
    Authentication
    GET                                     /mb/data/api/v2/sql?q=select%20*%20from%20${table}%20order%20by%20time%20desc%20limit%201;
    ${response} =                           Get Response Body
    [Return]                                ${response}

Clean Database
    Connect To Database Using Custom Params         psycopg2    database='mb_development_db', user='postgres', host='localhost', port=55433
    Execute Sql Script                              clean-db.sql
    Disconnect From Database

Insert Data
    [Arguments]                                 ${scenario}
    Run Process                                 python    insert_from_csv.py    --scenario    ${scenario}

Restart Container
    Run Process                                 docker    restart    mb_mbobject_traffic_mb_1

Expected Values
    [Arguments]                                                 ${expected}
    ${json_string} =   Catenate                                 ${expected}
    ${dic} =  evaluate                              json.loads('''${json_string}''')    json
    [Return]                                        ${dic}

Verify KPIs - Lane Level
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Log    ${expected}
    Log    ${data}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}

Verify KPIs - Direction Level
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Road Segment Level
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Road Segment Level_last24h
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    # Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Road Segment Level_current
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    # Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Area Level
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
#    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Area Level_last24h
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - Area Level_current
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
#    Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify KPIs - City Level
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Should Be Equal                             ${data["integration_period_s"]}    ${expected["integration_period_s"]}
    Should Be Equal                             ${data["number_vehicles"]}    ${expected["number_vehicles"]}
    Should Be Equal                             ${data["avg_speed_kmh"]}    ${expected["avg_speed_kmh"]}
    # Should Be Equal                             ${data["mi_avg_speed_kmh"]}    ${expected["mi_avg_speed_kmh"]}
    Should Be Equal                             ${data["occupancy_percentage"]}    ${expected["occupancy_percentage"]}
    Should Be Equal                             ${data["avg_length_m"]}    ${expected["avg_length_m"]}
    Should Be Equal                             ${data["avg_headway_ms"]}    ${expected["avg_headway_ms"]}
    Should Be Equal                             ${data["congested"]}    ${expected["congested"]}
    # Should Be Equal                             ${data["mi_congested"]}    ${expected["mi_congested"]}
    Should Be Equal                             ${data["period_inverted"]}    ${expected["period_inverted"]}
    Should Be Equal                             ${data["class_id"]}    ${expected["class_id"]}
    Should Be Equal                             ${data["class_count"]}    ${expected["class_count"]}
    # Should Be Equal                             ${data["mi_class_count"]}    ${expected["mi_class_count"]}
    Should Be Equal                             ${data["flow"]}    ${expected["flow"]}
    # Should Be Equal                             ${data["mi_flow"]}    ${expected["mi_flow"]}
    Should Be Equal                             ${data["density"]}    ${expected["density"]}
    # Should Be Equal                             ${data["mi_density"]}    ${expected["mi_density"]}
    Should Be Equal As Numbers                  ${data["security_separation_km"]}    ${expected["security_separation_km"]}
    Should Be Equal As Numbers                  ${data["capacity"]}    ${expected["capacity"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity"]}    ${expected["flow_per_capacity"]}
    # Should Be Equal                             ${data["mi_flow_per_capacity"]}    ${expected["mi_flow_per_capacity"]}
    Should Be Equal As Numbers                  ${data["max_density"]}    ${expected["max_density"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density"]}    ${expected["density_per_max_density"]}
    # Should Be Equal                             ${data["mi_density_per_max_density"]}    ${expected["mi_density_per_max_density"]}
    Should Be Equal                             ${data["los"]}    ${expected["los"]}
    # Should Be Equal                             ${data["mi_los"]}    ${expected["mi_los"]}
    # Should Be Equal                             ${data["mi"]}    ${expected["mi"]}

Verify Max And Mins
    [Arguments]                                 ${received}    ${expected}
    ${parsed_json} =    Parse Json              ${received}
    ${data} =     Set Variable                  ${parsed_json["rows"][0]}
    Log    ${data}
    Should Be Equal                             ${data["avgspeed_max"]}    ${expected["avgspeed_max"]}
    Should Be Equal                             ${data["avgspeed_min"]}    ${expected["avgspeed_min"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density_max"]}    ${expected["density_per_max_density_max"]}
    Should Be Equal As Numbers                  ${data["density_per_max_density_min"]}    ${expected["density_per_max_density_min"]}
    Should Be Equal As Numbers                  ${data["density_max"]}    ${expected["density_max"]}
    Should Be Equal As Numbers                  ${data["density_min"]}    ${expected["density_min"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity_max"]}    ${expected["flow_per_capacity_max"]}
    Should Be Equal As Numbers                  ${data["flow_per_capacity_min"]}    ${expected["flow_per_capacity_min"]}
