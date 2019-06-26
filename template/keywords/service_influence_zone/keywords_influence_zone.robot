*** Settings ***
Documentation     A resource file containing "Influence Zone Service" specific keywords.
Resource          ../keywords_commons.robot
Resource          ../service_custom_object/keywords_custom_object.robot
Variables         ../../variables/service_influence_zone/${ENV}_variables.py

*** Keywords ***
# Requests
Set Influence Zone Shape Definition
    [Arguments]                             ${id}    ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Run Keyword And Ignore Error            PUT    /mb/influences/shapes/${id}

Get Influence
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Run Keyword And Ignore Error            POST    /mb/influences/geometry

Get Influence Zone Shape Definition
    [Arguments]                             ${id}
    Authentication
    Run Keyword And Ignore Error            GET     /mb/influences/shapes/${id}

List Influence Zones Shapes
    Authentication
    Run Keyword And Ignore Error            GET     /mb/influences/shapes

Delete Influence Zone Shape Definition
    [Arguments]                             ${id}
    Authentication
    Run Keyword And Ignore Error            DELETE                                  /mb/influences/shapes/${id}

Set Instance Position
    [Arguments]                             ${object_type}    ${id}    ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Run Keyword And Ignore Error            POST     /objects/${object_type}/instances/${id}/position

Delete Instance Position
    [Arguments]                             ${object_type}    ${id}
    Authentication
    Set Request Header                      Content-Type    application/json
    Run Keyword And Ignore Error            DELETE    /objects/${object_type}/instances/${id}/position

Get object Types With Shape
    Authentication
    Run Keyword And Ignore Error            GET    /mb/influences/types

Create Environment
    Create Object                           {"object_type": "robot_iz_test", "name": "Robot Custom Object", "core": false}
    Set Influence Zone Shape Definition     robot_iz_test    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Update Object Schema                    robot_iz_test   {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                  robot_iz_test   {"name":"IZ ENV INSTANCE 1","test_id":{"value":"IZ_INSTANCE_TEST_START"},"geometry":{"type":"Point","coordinates":[-66.901235, 10.499412]}}
    Create Object Instance                  robot_iz_test   {"name":"IZ ENV INSTANCE 2","test_id":{"value":"IZ_INSTANCE_TEST_MEDIUM"},"geometry":{"type":"Point","coordinates":[-66.907351, 10.500827]}}
    Create Object Instance                  robot_iz_test   {"name":"IZ ENV INSTANCE 3","test_id":{"value":"IZ_INSTANCE_TEST_FINISH"},"geometry":{"type":"Point","coordinates":[-66.911057, 10.501664]}}

Delete Environment
    Delete Instance By Extenal ID           robot_iz_test    test_id    IZ_INSTANCE_TEST_START
    Delete Instance By Extenal ID           robot_iz_test    test_id    IZ_INSTANCE_TEST_MEDIUM
    Delete Instance By Extenal ID           robot_iz_test    test_id    IZ_INSTANCE_TEST_FINISH
    Delete Object                           robot_iz_test
    Delete Influence Zone Shape Definition  robot_iz_test
