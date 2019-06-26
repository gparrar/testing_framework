*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           SikuliLibrary
Library           Selenium2Library
Library           ../../libraries/object_traffic/traffic_library.py
Resource          ../keywords_commons.robot
Variables         ../../variables/global_paths.py
Variables         ../../variables/global_${ENV}.py
Variables         ../../variables/object_traffic/${ENV}_variables.py


*** Keywords ***
Setup Main
# TODO move to general
    Open Browser To Login Page
    Log in

Open Package
    Click Element                           ${menu_button}
    Wait Until Element is Visible           ${left_menu}
    Assign Id To Element                    ${areas_table}    areas_table

Setup Traffic
    Open Browser To Login Page
    Log In
    Open Package

Teardown Traffic
    Log Out
    Close Browser

Verify Left Menu
    Verify Icon and Label    menuicon       ${icon_xpath}    ${menu_title}    ${label_xpath}

Validate Tooltip
    Mouse Over                              ${menu_button}/div[2]
    Element Text Should Be                  ${menu_button}/div[3]/span    ${menu_tooltip}

Validate Title
    Element Text Should Be                  ${menu_title_path}    ${title}

Verify Icon and Label
    [Arguments]                             ${icon}    ${icon_path}    ${label}    ${label_path}
    Wait Until Element is Visible           ${icon_path}
    Element should be visible               ${icon_path}
    Page should contain image               ${icon_path}
    Element Text Should Be                  ${label_path}    ${label}
    ${img src}=    Get element attribute    ${icon_path}@src
    Create HTTP Context                     ${SERVER}  ${SCHEME}
    Set Basic Auth                          ${VALID USER}    ${VALID PASSWORD}
    GET                                     ${img src}
    ${response}                             Get Response Status
    Should be equal as Strings    ${response}    200 OK
    Download a file    ${icon}    ${img src}
    Compare Images     ${ROBOT_DIR}/resources/object_traffic/images/${icon}.png    /tmp/${icon}    0.1


Validate Flow Rate / Capacity
    ${api} =    Get KPIs                    ${CITY_QUERY}
    Log    ${api}
    ${expected} =    Prepare Response       ${api}    flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Flow Rate / Capacity MI
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    mi_flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${mi_flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Matching Index
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    mi
    ${web} =    Selenium2Library.Get Text                    ${mi_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Density / Max. Density
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Density / Max. Density MI
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    mi_density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${mi_density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Congestion
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    congested
    ${web} =    Selenium2Library.Get Text   ${congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Congestion MI
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    mi_congested
    ${web} =    Selenium2Library.Get Text   ${mi_congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Peak Hour Factor
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Peak Hour Factor MI
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    mi_peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${mi_phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Level of Service
    ${api} =    Get KPIs                    ${CITY_QUERY}
    ${expected} =    Prepare Response       ${api}    los
    ${web} =    Selenium2Library.Get Text   ${los_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Order By
    [Arguments]                                     ${criteria}    ${order}
    Run Keyword If    "${criteria}" == "area"       Select From List By Value    sorttraficTable    area_name
    Run Keyword If    "${criteria}" == "flow"       Select From List By Value    sorttraficTable    flow_per_capacity
    Run Keyword If    "${criteria}" == "density"    Select From List By Value    sorttraficTable    density_per_max_density
    Run Keyword If    "${criteria}" == "phf"        Select From List By Value    sorttraficTable    peak_hour_factor
    Run Keyword If    "${criteria}" == "matching"   Select From List By Value    sorttraficTable    mi
    Run Keyword If    "${criteria}" == "los"        Select From List By Value    sorttraficTable    los
    Run Keyword If    "${order}" == "desc"          Click Element    desctraficTable
    Run Keyword If    "${order}" == "asc"           Click Element    asctraficTable

Get Web Values
    [Arguments]                                     ${criteria}    ${order}
    Wait Until Element is Visible                   css=div.table_on_hover
    Order By                                        ${criteria}    ${order}
    ${count} =   Get Matching Xpath Count           //*[@id="areas_table"]/div
    ${values_list} =    Create List
    :FOR    ${index}     IN RANGE     1             ${count} + 1
    \    ${path} =    Set Variable If
    ...     "${criteria}" == "area"                 //*[@id="areas_table"]/div[${index}]/div[2]/p
    ...     "${criteria}" == "flow"                 //*[@id="areas_table"]/div[${index}]/div[3]/p
    ...     "${criteria}" == "density"              //*[@id="areas_table"]/div[${index}]/div[4]/p
    ...     "${criteria}" == "phf"                  //*[@id="areas_table"]/div[${index}]/div[5]/p
    ...     "${criteria}" == "matching"             //*[@id="areas_table"]/div[${index}]/div[7]/p
    ...     "${criteria}" == "los"                  //*[@id="areas_table"]/div[${index}]/div[8]/p
    \    ${value} =   Selenium2Library.Get Text     ${path}
    \    Append To List    ${values_list}           ${value}
    [Return]    ${values_list}

Validate Sorting
    [Arguments]                                     ${criteria}     ${order}
    ${api} =    Get KPIs                            ${AREAS_TABLE_QUERY}
    Log    ${api}
    ${expected} =    Prepare Areas Table Response   ${api}    ${criteria}    ${order}
    ${web} =    Get Web Values                      ${criteria}    ${order}
    Lists Should Be Equal                           ${web}   ${expected}

Open Area Popup
    Element Should Not Be Visible           popup-generic
    Wait Until Element Is Visible           ${element_in_table}
    Click Element                           ${element_in_table}
    Wait Until Element Is Visible           popup-generic
    Element Should Be Visible               css=span.valign

Open Element Popup
    [Arguments]                             ${type}=rs
    ${name} =    Set Variable If
    ...     "${type}" == "rs"               marker.png
    ...     "${type}" == "area"             area.png
    Element Should Not Be Visible           popup-generic
    Add Image Path                          ${ROBOT_DIR}/resources/object_traffic/images/markers/
    Wait Until Screen Contain               ${name}    5
    Click                                   ${name}
    Wait Until Element Is Visible           ${popup_element_kpis}
    Element Should Be Visible               css=span.valign

Close Popup
    Click Element                           ${popup_close}
    Wait Until Element Is Not Visible       popup-generic
    Element Should Not Be Visible           popup-generic

Verify Private Layers Menu
    Verify Icon and Label    table-phf      ${phf_icon_xpath}    ${phf_label}    ${phf_label_xpath}
    Verify Icon and Label    layermatch     ${mi_icon_xpath}    ${mi_label}    ${mi_label_xpath}
    Verify Icon and Label    layerdensity   ${density_icon_xpath}    ${density_label}    ${density_label_xpath}
    Verify Icon and Label    layerflow      ${flow_icon_xpath}    ${flow_label}    ${flow_label_xpath}
    Verify Icon and Label    layerarea      ${area_icon_xpath}    ${area_label}    ${area_label_xpath}
    Verify Icon and Label    layerroad      ${road_icon_xpath}    ${road_label}    ${road_label_xpath}

Verify Header Of Area Popup
    ${api} =    Get KPIs                    ${AREA_INFO}
    Element Text Should Be                  ${popup_header}    ID: ${api[0]["area_id"]} - ${api[0]["area_name"]}

Verify Header Of Element Popup
    ${api} =    Get KPIs                    ${RS_INFO}
    Element Text Should Be                  ${popup_header}    ID: ${api[0]["external_id"]} - ${api[0]["name"]}

# AREA
Validate Area Flow
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    flow
    ${web} =    Selenium2Library.Get Text   ${popup_area_flow_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Flow MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_flow
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_flow_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Flow Rate / Capacity
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${popup_area_flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Flow Rate / Capacity MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Peak Hour Factor
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${popup_area_phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Peak Hour Factor MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Density
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    density
    ${web} =    Selenium2Library.Get Text   ${popup_area_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Density MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_density
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Density / Max. Density
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${popup_area_density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Density / Max. Density MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Avg. Speed
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    avg_speed_kmh
    ${web} =    Selenium2Library.Get Text   ${popup_area_avgspeed_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Avg. Speed MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_avg_speed_kmh
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_avgspeed_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Congestion
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    congested
    ${web} =    Selenium2Library.Get Text   ${popup_area_congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Congestion MI
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    mi_congested
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi_congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Area Level of Service
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    los
    ${web} =    Selenium2Library.Get Text   ${popup_area_los_counter}
    Should Be Equal As Strings              ${web}    ${expected}

# ELEMENT
Query Level
    [Arguments]                             ${level}
    ${query} =    Set Variable If
    ...     "${level}" == "rs"              ${RS_INFO}
    ...     "${level}" == "direction"       ${DIRECTION_INFO}
    ...     "${level}" == "lane"            ${LANE_INFO}
    [Return]                                ${query}

Validate Element Flow
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    flow
    ${web} =    Selenium2Library.Get Text   ${popup_element_flow_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Flow MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_flow
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_flow_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Flow Rate / Capacity
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${popup_element_flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Flow Rate / Capacity MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_flow_per_capacity
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_flow_per_capacity_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Peak Hour Factor
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${popup_element_phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Peak Hour Factor MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_peak_hour_factor
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_phf_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Density
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    density
    ${web} =    Selenium2Library.Get Text   ${popup_element_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Density MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_density
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Density / Max. Density
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${popup_element_density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Density / Max. Density MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_density_per_max_density
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_density_per_max_density_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Avg. Speed
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    avg_speed_kmh
    ${web} =    Selenium2Library.Get Text   ${popup_element_avgspeed_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Avg. Speed MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_avg_speed_kmh
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_avgspeed_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Congestion
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    congested
    ${web} =    Selenium2Library.Get Text   ${popup_element_congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Congestion MI
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    mi_congested
    ${web} =    Selenium2Library.Get Text   ${popup_element_mi_congestion_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Element Level of Service
    [Arguments]                             ${level}
    ${query} =    Query Level               ${level}
    ${api} =    Get KPIs                    ${query}
    ${expected} =    Prepare Response       ${api}    los
    ${web} =    Selenium2Library.Get Text   ${popup_element_los_counter}
    Should Be Equal As Strings              ${web}    ${expected}

Select Direction
    Wait Until Element is Visible           ${popup_element_direction_selector}    timeout=${timeout}
    Click Element                           ${popup_element_direction_selector}

Select Lane
    Wait Until Element is Visible           ${popup_element_lane_selector}    timeout=${timeout}
    Click Element                           ${popup_element_lane_selector}

# Layers
Select Flow Rate / Capacity Layer
    Wait Until Element is Visible           ${flow_icon_xpath}
    Click Element                           ${flow_icon_xpath}

Select Density / Max Density Layer
    Wait Until Element is Visible           ${density_icon_xpath}
    Click Element                           ${density_icon_xpath}

Select Matching Index Layer
    Wait Until Element is Visible           ${mi_icon_xpath}
    Click Element                           ${mi_icon_xpath}

Select PHF Layer
    Wait Until Element is Visible           ${phf_icon_xpath}
    Click Element                           ${phf_icon_xpath}

Select Area Layer
    Wait Until Element is Visible           ${area_icon_xpath}
    Click Element                           ${area_icon_xpath}

# Map
Center The Map
    Center The Map At Element               ${center_coordinates}     ${zoom}
