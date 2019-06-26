*** Settings ***
Documentation     A resource file containing "Influence Zone Service" specific keywords to interact with GUI.
Resource          ../keywords_commons.robot
Resource          ../service_custom_object/keywords_custom_object.robot
Variables         ../../variables/service_influence_zone/${ENV}_variables.py
#Variables         ../../variables/service_influence_zone/fixtures.py


*** Keywords ***
Setup IZ
    Open Browser To Login Page
    Log In

    Copy Assets
    Create Object Type                      {"object_type": "robot_iz_test_1", "name": "Robot Influencer", "core": false}
    Create Object Type                      {"object_type": "robot_iz_test_2", "name": "Robot Influenced", "core": false}
    Set Influence Zone Shape Definition     robot_iz_test_1    {"geometry": {"type": "Buffer", "radius": 100} ,"role":"influencer","tags": {"core": false, "hasActions": "indeed"}}
    Update Object Schema                    robot_iz_test_1    {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                  robot_iz_test_1    {"name":"IZ ENV INSTANCE 1","test_id":{"value":"IZ_INSTANCE_TEST_INFLUENCER"},"geometry":{"type":"Point","coordinates":[2.150949, 41.408847]}}

    Set Influence Zone Shape Definition     robot_iz_test_2    {"geometry": {"type": "Buffer", "radius": 100} ,"role":"influenced","tags": {}}
    Update Object Schema                    robot_iz_test_2    {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                  robot_iz_test_2    {"name":"IZ ENV INSTANCE 2","test_id":{"value":"IZ_INSTANCE_TEST_INFLUENCED"},"geometry":{"type":"Point","coordinates":[2.152075, 41.407695]}}

    #Create Object                           ${affected}
    #Set Influence Zone Shape Definition     robot_iz_test_1    ${shape10}
    #Update Object Schema                    robot_iz_test_1    ${schema}
    #Create Object Instance                  robot_iz_test_1    {"name": "IZ ENV INSTANCE 1", "test_id": {"value": "IZ_INSTANCE_TEST_INFLUENCER"}, "geometry": {"type": "Point", "coordinates": [2.189936, 41.387126]}}
    #Set Influence Zone Shape Definition     robot_iz_test_2    ${shape20}
    #Update Object Schema                    robot_iz_test_2    ${schema}
    #Create Object Instance                  robot_iz_test_2    {"name": "IZ ENV INSTANCE 2", "test_id": {"value": "IZ_INSTANCE_TEST_INFLUENCED"}, "geometry": {"type": "Point", "coordinates": [2.1870208, 41.3859605]}}

Restore Environment By Default
    Remove Assets
    Delete Instance By Extenal ID           robot_iz_test_1    test_id    IZ_INSTANCE_TEST_INFLUENCER
    Delete Instance By Extenal ID           robot_iz_test_2    test_id    IZ_INSTANCE_TEST_INFLUENCED
    Delete Influence Zone Shape Definition  robot_iz_test_1
    Delete Influence Zone Shape Definition  robot_iz_test_2
    Delete Object                           robot_iz_test_1
    Delete Object                           robot_iz_test_2
    # TODO name should be Delete Object Type
    Log Out
    Close Browser

Expand Influence Zone Panel
    Click Element                   ${iz_button}
    Wait Until Element Is Visible   ${iz_panel}
    Element Should Be Visible       ${iz_panel}

Collapse Influence Zone Panel
    Click Element                   ${iz_panel_header}
    Element Should Not Be Visible   ${iz_panel}

Get Influence Zone
    Assign Id To Element            //*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]    Tile
    #Assign Id To Element            xpath:${ciutadella_tile}    Tile
    Open Context Menu               Tile
    Click Element                   xpath://div[contains(@class,"ContextMenu__MapContextMenu")]/div
    Wait Until Element is Visible   css:input.Grid-cell

Select Filter
    [Arguments]                                         ${filter}
    Wait Until Element is Visible                       ${influencer_filter_xpath}
    Wait Until Element is Visible                       ${influenced_filter_xpath}
    Run Keyword If    '${filter}' == 'Actions'          Click Element
    Run Keyword If    '${filter}' == 'Influencer'       Click Element    ${influencer_filter_xpath}
    Run Keyword If    '${filter}' == 'Influenced'       Click Element    ${influenced_filter_xpath}
    Run Keyword If    '${filter}' == 'Police Agent'     Click Element    ${tracking_element_xpath}
    Run Keyword If    '${filter}' == 'Instance 1'       Click Element    ${first_iz_element_xpath}
    Run Keyword If    '${filter}' == 'Instance 2'       Click Element    ${second_iz_element_xpath}

Verify Elements List
    Wait Until Element is Visible   ${first_element_name_xpath}
    Wait Until Element is Visible   ${second_element_name_xpath}
    Wait Until Element is Visible   ${third_element_name_xpath}
    Element Text Should Be          ${first_element_name_xpath}         ${first_element_name}
    Element Text Should Be          ${first_element_distance_xpath}     ${first_element_distance}
    Element Text Should Be          ${second_element_name_xpath}        ${second_element_name}
    Element Text Should Be          ${second_element_distance_xpath}    ${second_element_distance}
    Element Text Should Be          ${third_element_name_xpath}         ${third_element_name}
    Element Text Should Be          ${third_element_distance_xpath}     ${third_element_distance}
    Element Text Should Be          ${fourth_element_name_xpath}        ${fourth-element-name}
    Element Text Should Be          ${forth_element_distance_xpath}     ${fourth-element-distance}

Verify Influencer Elements Are Not Displayed
    Element Should Not Be Visible               second-element-name
    Element Text Should Be                      first-element-name      ${first_element_name}
    Element Text Should Be                      third-element-name      ${third_element_name}

Verify Influenced Elements Are Not Displayed
    Element Should Not Be Visible               third_element_name
    Element Should Not Be Visible               first-element-name
    Element Text Should Be                      second-element-name     ${second_element_name}

Verify The First Element Is Not Displayed
    Element Should Not Be Visible               first-element-name
    Element Text Should Be                      second-element-name     ${second_element_name}
    Element Text Should Be                      third-element-name      ${third_element_name}

Verify Only The Second Element Is Displayed
    Element Should Not Be Visible               first-element-name
    Element Should Not Be Visible               third-element-name
    Element Text Should Be                      second-element-name     ${second_element_name}

Verify Only The Third Element Is Displayed
    Element Should Not Be Visible               first-element-name
    Element Should Not Be Visible               second-element-name
    Element Text Should Be                      third-element-name     ${third_element_name}

Verify Tooltip
    [Arguments]                                 ${element}    ${value}
    ${text} =    Get Element Attribute          ${element}    title
    Should Be Equal                             ${text}    ${value}

Verify Tooltips
    Verify Tooltip                              ${influencer_filter_xpath}    Influencers
    Verify Tooltip                              ${influenced_filter_xpath}    Influenceds
    Verify Tooltip                              ${tracking_element_xpath}     mb_tracking
    Verify Tooltip                              ${first_iz_element_xpath}     Robot Influencer
    Verify Tooltip                              ${second_iz_element_xpath}    Robot Influenced

# TODO move to generic
Open Popup
    Element Should Not Be Visible           ${popup_header}
    Click Element                           first-element-name
    Wait Until Element Is Visible           ${popup_header}
    Element Text Should Be                  ${popup_header}    ${first_element_name}

Close Popup
    Click Element                       ${popup_close_button}
    Wait Until Element Is Not Visible   popup-generic
    Element Should Not Be Visible       popup-generic

Drag Radius Slider
    [Arguments]                             ${x-offset}
    Drag And Drop By Offset                 ${slider_xpath}    ${x-offset}    0

Verify Radius Value
    [Arguments]                             ${value}
    Element Text Should Be                  ${slider_radius_xpath}    ${value}

Search For Specific Element
    [Arguments]                             ${text}
    Wait Until Element is Visible           ${search_bar_xpath}
    Input Text                              ${search_bar_xpath}    ${text}

# Setup
Copy Assets
    Backup Default userConfigurations
    Copy Asset                              ${ROBOT_DIR}/${resources_path}/webapp_conf/userConfigurations.yaml    /var/opt/mb/webapp_conf/userConfigurations.yaml
    Copy Directory                          ${ROBOT_DIR}/${resources_path}/webapp_conf/public/RobotA/    /var/opt/mb/webapp_conf/public/RobotA
    Copy Directory                          ${ROBOT_DIR}/${resources_path}/webapp_conf/public/RobotB/    /var/opt/mb/webapp_conf/public/RobotB

Remove Assets
    Restore Default userConfigurations
    Remove Directory                        /var/opt/mb/webapp_conf/public/RobotA
    Remove Directory                        /var/opt/mb/webapp_conf/public/RobotB
