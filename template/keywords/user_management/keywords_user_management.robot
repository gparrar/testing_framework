*** Settings ***
Documentation     A resource file containing "User Management" specific keywords to interact with GUI.
Resource          ../keywords_commons.robot
Variables         ../../variables/user_management/${ENV}_variables.py

*** Keywords ***
Test Custom Object Endpoint
    GET                                     /mb/objects
    Response Status Code Should Equal       200 OK

Test SQL API
    GET                                     /mb/data/api/v2/sql?q=${query}
    Response Status Code Should Equal       200 OK

Test Maps API
    GET                                     /mb/map/api/v1/map?stat_tag=API&config=%7B"version"%3A"1.3.0"%2C"stat_tag"%3A"API"%2C"layers"%3A%5B%7B"type"%3A"cartodb"%2C"options"%3A%7B"sql"%3A"select%20meta.core_id%20as%20id%2C%20meta.core_id%20as%20core_id%2C%20meta.name%20as%20name%2C%20(external_id%20%7C%7C%20%27%20-%20%27%20%7C%7C%20name)%20as%20tooltipname%2C%20flow%20as%20tooltipextra%2C%20data.flow_per_capacity%20as%20value%2C%20meta.the_geom_webmercator%20from%20(SELECT%20*%20FROM%20traffic_mb_ts_roadsegment_measurements_realtime_current%20WHERE%20time%20>%20now()%20-%20interval%20%2730%20minutes%27)%20AS%20data%20RIGHT%20JOIN%20traffic_mb_meta_roadsegment%20meta%20on%20data.road_segment_id%20%3D%20meta.core_id%3B"%2C"cartocss"%3A"%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%20%7B%5Cn%20%20%20%20%20%20%20%20%20%20marker-fill-opacity%3A%200.6%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-line-color%3A%20%23FFF%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-line-width%3A%201%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-line-opacity%3A%201%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-placement%3A%20point%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-type%3A%20ellipse%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-allow-overlap%3A%20true%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-width%3A%2080%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-fill%3A%20%23c97a04%3B%5Cn%20%20%20%20%20%20%20%20%7D%5Cn%20%20%20%20%20%20%20%20%23cartodbcss_traffic_rs%20%7B%5Cn%20%20%20%20%20%20%20%20%20%20marker-file%3A%20url(https%3A%2F%2Fdevelopment.mobility.wocs3.com%2Fpublic%2FTraffic%2Fmarkers%2Fmarker.png)%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-placement%3A%20point%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-width%3A%2027%3B%5Cn%20%20%20%20%20%20%20%20%20%20marker-allow-overlap%3A%20true%3B%5Cn%20%20%20%20%20%20%20%20%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0%5D%20%7Bmarker-fill%3A%20%238cce8a%3B%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0.16666666666666666%5D%20%7Bmarker-fill%3A%20%23d2ecb4%3B%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0.3333333333333333%5D%20%7Bmarker-fill%3A%20%23fff2cc%3B%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0.5%5D%20%7Bmarker-fill%3A%20%23fed6b0%3B%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0.6666666666666666%5D%20%7Bmarker-fill%3A%20%23f79272%3B%7D%23cartodbcss_traffic_rs%3A%3Aglow%5Bzoom%20>%3D%207%5D%5Bvalue>%3D0.8333333333333333%5D%20%7Bmarker-fill%3A%20%23d73027%3B%7D"%2C"cartocss_version"%3A"2.1.0"%2C"interactivity"%3A%5B"id"%2C"core_id"%2C"name"%2C"tooltipextra"%2C"tooltipname"%5D%7D%7D%5D%7D&callback=_cdbc_3081154918_1
    Response Status Code Should Equal       200 OK

Test Influences Endpoint
    GET                                     /mb/influences/shapes
    Response Status Code Should Equal       200 OK

Test Actions Endpoint
    GET                                     /mb/actions
    Response Status Code Should Equal       200 OK

Test Action Endpoint
    GET                                     /mb/objects/instances/49/actionlog
    Response Status Code Should Equal       200 OK

Test Action
    GET                                     /mb/actions/robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK

Test Actions With Invalid User
    Next Request Should Not Succeed
    GET                                     /mb/actions/robot_group/semaforos/apagar
    Response Status Code Should Equal       401 Unauthorized

Register Actions
    Configure Actions    robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/"}]
