*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           SikuliLibrary
Library           Selenium2Library
Library           ../../libraries/datafeed_traveltimes/traveltimes_library.py
Resource          ../keywords_commons.robot
Resource          ../setup_common.robot
Variables         ../../variables/global_paths.py
Variables         ../../variables/global_${ENV}.py
Variables         ../../variables/datafeed_traveltimes/${ENV}_variables.py


*** Keywords ***
Open Package
    Click Element                           ${menu_button}
    Wait Until Element is Visible           ${left_menu}
    #Assign Id To Element                    ${routes_table}    routes_table

Setup Traveltimes
    Open Browser To Login Page
    Log In
    Open Package

Teardown Traveltimes
    Log Out
    Close Browser

Open Route Popup
    Element Should Not Be Visible           popup-generic
    Wait Until Element Is Visible           ${element_in_table}
    Order by                                name    asc
    Click Element                           ${element_in_table}
    Wait Until Element Is Visible           popup-generic
    Element Should Be Visible               css:span.valign


Open Link Popup
    Element Should Not Be Visible           popup-generic
    #${point}=     Get Point From Coordinates    2.18902587890625  41.38299120166604
    Sleep    1
    ${point}=     Get Point From Coordinates    2.188813  41.383395
    ${pointx}=    Evaluate    ${point}["x"]
    ${pointy}=    Evaluate    ${point}["y"]
    Click Element At Coordinates            map       ${pointx}      ${pointy}
    Capture Page Screenshot
    Wait Until Element Is Visible           popup-generic
    Element Should Be Visible               css=span.valign

Close Popup
    Click Element                           ${popup_close}
    Element Should Not Be Visible           popup-generic

Validate Label
    Element Text Should Be                  ${menu_button}/div[2]    ${menu_title}

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
    Compare Images     ${ROBOT_DIR}/resources/datafeed_traveltimes/images/${icon}.png    /tmp/${icon}    0.1

Verify Left Menu
    Verify Icon and Label    menuicon       ${icon_xpath}    ${menu_title}    ${label_xpath}

Validate City Average Speed
    ${api} =    Get KPIs                    ${CITY_AVG_SPEED}
    ${expected} =    Prepare Response       ${api}    avg
    ${web} =    Selenium2Library.Get Text             ${average_speed}
    Should Be Equal As Strings              ${web}    ${expected}

Validate City Level Of Service
    ${api} =    Get KPIs                    ${CITY_LOS}
    ${expected} =    Prepare Los Response   ${api}    red
    Sleep     3s
    ${web} =    Selenium2Library.Get Text                    ${bad_los}
    Should Be Equal As Strings              ${web}    ${expected}
    ${expected} =    Prepare Los Response   ${api}    yellow
    ${web} =    Selenium2Library.Get Text                    ${medium_los}
    Should Be Equal As Strings              ${web}    ${expected}
    ${expected} =    Prepare Los Response   ${api}    green
    ${web} =    Selenium2Library.Get Text                    ${good_los}
    Should Be Equal As Strings              ${web}    ${expected}
    # ${expected} =    Prepare Los Response   ${api}    black
    # ${web} =    Selenium2Library.Get Text                    ${unknown_los}
    # Should Be Equal As Strings              ${web}    ${expected}

Validate City Matching Index
    ${api} =    Get KPIs                    ${CITY_MI}
    ${expected} =    Prepare Response       ${api}    speed_match
    ${web} =    Selenium2Library.Get Text                    ${matching_index}
    Should Be Equal As Strings              ${web}    ${expected}

Order By
    [Arguments]                                         ${criteria}    ${order}
    Run Keyword If    "${criteria}" == "speed"          Select From List By Value    ${sort_selector}    current_speed
    Run Keyword If    "${criteria}" == "name"           Select From List By Value    ${sort_selector}    name_from
    Run Keyword If    "${criteria}" == "time"           Select From List By Value    ${sort_selector}    current_elapsed_time
    Run Keyword If    "${criteria}" == "speed_range"    Select From List By Value    ${sort_selector}    levelofservice
    Run Keyword If    "${criteria}" == "matching"       Select From List By Value    ${sort_selector}    speed_match
    Run Keyword If    "${order}" == "desc"              Click Element    ${table_desc_button}
    Run Keyword If    "${order}" == "asc"               Click Element    ${table_asc_button}

Get Web Values
    [Arguments]                                         ${criteria}    ${order}
    Wait Until Element is Visible                       css=div.table_on_hover
    Order By                                            ${criteria}    ${order}
    ${count}=    Get Matching Xpath Count               ${main_routes_base}/div
    ${values_list}=    Create List
    :FOR    ${index}     IN RANGE     1                 ${count} + 1
    \    ${path} =    Set Variable If
    ...     "${criteria}" == "speed"                    ${main_routes_base}/div[${index}]/div[2]/div[1]/div/p/span
    ...     "${criteria}" == "name"                     ${main_routes_base}/div[${index}]/div[1]/p
    ...     "${criteria}" == "time"                     ${main_routes_base}/div[${index}]/div[3]/div/p[4]
    ...     "${criteria}" == "speed_range"              ${main_routes_base}/div[${index}]/div[4]/div/div[1]/span
    ...     "${criteria}" == "matching"                 ${main_routes_base}/div[${index}]/div[5]/div/p/span[1]
    \    ${value} =   Selenium2Library.Get Text    ${path}
    \    Append To List    ${values_list}               ${value}
    [Return]    ${values_list}

Validate Sorting
    [Arguments]                                         ${criteria}     ${order}
    ${api}=     Get KPIs                                ${ROUTES TABLE QUERY}
    ${expected} =    Prepare Routes Table Response      ${api}    ${criteria}    ${order}
    ${web} =    Get Web Values                          ${criteria}    ${order}
    Lists Should Be Equal                               ${web}   ${expected}

Verify Private Layers Menu
    Verify Icon and Label    layerabs       ${abs_speed_icon_xpath}     ${abs_speed_label}      ${abs_speed_label_xpath}
    Verify Icon and Label    layerspeed     ${speed_range_icon_xpath}   ${speed_range_label}    ${speed_range_label_xpath}
    Verify Icon and Label    layermatch     ${mi_icon_xpath}            ${mi_label}             ${mi_label_xpath}

Select Abs. Speed Layer
    Wait Until Element is Visible           ${abs_speed_icon_xpath}
    Click Element                           ${abs_speed_icon_xpath}

Select Speed Range Layer
    Wait Until Element is Visible           ${speed_range_icon_xpath}
    Click Element                           ${speed_range_icon_xpath}

Select Matching Index Layer
    Wait Until Element is Visible           ${mi_icon_xpath}
    Click Element                           ${mi_icon_xpath}

Check Layer
    [Arguments]                             ${type}
    Add Image Path                          ${ROBOT_DIR}/resources/datafeed_traveltimes/images/layers/
    ${name} =    Set Variable If
    ...     "${type}" == "speed"             speed.png
    ...     "${type}" == "speed_range"       speed_range.png
    ...     "${type}" == "mi"                mi.png
    Wait Until Screen Contain               ${name}    5

Verify Header Of Route Popup
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${distance_in_km} =    Evaluate         str(round(float(${api[0]["distance"]})/1000,2)).replace('.', ',')
    Element Text Should Be                  ${popup_header}    ${api[0]["name_from"]} - ${api[0]["name_to"]}\n[${distance_in_km}km]

Validate Route Average Speed
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${expected} =    Prepare Response       ${api}    current_speed
    ${web} =    Selenium2Library.Get Text                    ${popup_route_average_speed}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Route Expected Time
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${expected} =    Prepare Response       ${api}    expected_elapsed_time
    ${web} =    Selenium2Library.Get Text                    ${popup_route_expected_time}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Route Real Time
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${expected} =    Prepare Response       ${api}    current_elapsed_time
    ${web} =    Selenium2Library.Get Text                    ${popup_route_real_time}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Route Level Of Service
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${expected} =    Prepare Response       ${api}    levelofservice
    ${web} =    Selenium2Library.Get Text                    ${popup_route_los}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Route Matching Index
    ${api} =    Get KPIs                    ${SINGLE_ROUTE_INFO}
    ${expected} =    Prepare Response       ${api}    speed_match
    ${web} =    Selenium2Library.Get Text                    ${popup_route_mi}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Header Of Link Popup
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${distance_in_km} =    Evaluate         str(round(float(${api[0]["distance"]})/1000,2)).replace('.', ',')
    Element Text Should Be                  ${popup_header}    ${api[0]["name_from"]} - ${api[0]["name_to"]}

Validate Link Average Speed
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${expected} =    Prepare Response       ${api}    current_speed
    ${web} =    Selenium2Library.Get Text                    ${popup_link_average_speed}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Link Expected Time
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${expected} =    Prepare Response       ${api}    expected_elapsed_time
    ${web} =    Selenium2Library.Get Text   ${popup_link_expected_time}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Link Real Time
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${expected} =    Prepare Response       ${api}    current_elapsed_time
    ${web} =    Selenium2Library.Get Text                    ${popup_link_real_time}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Link Level Of Service
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${expected} =    Prepare Response       ${api}    levelofservice
    ${web} =    Selenium2Library.Get Text                    ${popup_link_los}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Link Matching Index
    ${api} =    Get KPIs                    ${SINGLE_LINK_INFO}
    ${expected} =    Prepare Response       ${api}    speed_match
    ${web} =    Selenium2Library.Get Text                    ${popup_link_mi}
    Should Be Equal As Strings              ${web}    ${expected}

'//*[@id="popup-generic"]/div/div[1]/div[2]/div[1]/div/div[5]/div/p/span[1]
