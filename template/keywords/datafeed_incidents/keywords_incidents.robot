*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           DateTime
Library           Selenium2Library
Library           ../../libraries/datafeed_incidents/incidents_library.py
Resource          ../keywords_commons.robot
Variables         ../../variables/global_paths.py
Variables         ../../variables/global_${ENV}.py
Variables         ../../variables/datafeed_incidents/${ENV}_variables.py


*** Keywords ***
#TODO
Setup Main View
    Open Browser To Login Page
    Log In

Open Package
    Click Element                          ${menu_button_id}
    Wait Until Page Does Not Contain Element    class:loader-spin
    Assign Id To Element                    //*[@id="leftside"]/div/div[5]/div[2]    incidents_table
    Assign Id To Element                    //*[@id="app"]/div/div/div[3]/div[2]    private_layers

Setup Incidents
    Open Browser To Login Page
    Log In
    Open Package

Teardown Incidents
    Log Out
    Close Browser

Validate Tooltip
    Selenium2Library.Log Location
    #Mouse Over                             ${menu_button}/div[2]
    Mouse Over                              ${menu_button_id}
    Element Text Should Be                  ${menu_button}/div[3]/span    ${menu_tooltip}

Validate Title
    Element Text Should Be                  ${menu_title_path}    ${title}

Verify Left Menu
    Verify Icon and Label    menuicon       ${icon_xpath}    ${menu_title}    ${label_xpath}

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
    Should be equal as Strings              ${response}    200 OK
    Download a file                         ${icon}    ${img src}
    Compare Images                          ${ROBOT_DIR}/resources/datafeed_incidents/images/${icon}.png    /tmp/${icon}    0.1

Validate Label
    Element Text Should Be                  ${menu_button}/div[2]    ${menu_title}


Get Web Incident Types
    Wait Until Element Contains           filterfilter-incidences    all
    ${types} =   Get List Items           filterfilter-incidences
    [Return]                              ${types}

Validate Incident Types
    @{api} =    Get KPIs    ${INCIDENT_TYPES}
    Log    ${api}
    @{sorted} =    Evaluate    sorted(@{api}, key=lambda k: k["name"])
    ${list}    Create List
    :FOR    ${item}    IN    @{sorted.json}:
    \    Log    ${item}
    \    Append To List    ${list}    ${item["name"]}
    ${web} =    Get Web Incident Types
    Log    ${list}
    Remove From List    ${web}    0
    Lists Should Be Equal    ${list}    ${web}

Open Area Popup
    Element Should Not Be Visible       popup-generic
    Wait Until Element Is Visible       ${area_chart}
    Sleep    2
    Click Element                       ${area_chart}
    Wait Until Element Is Visible       popup-generic
    Element Should Be Visible           css=span.valign

Open Incident Popup
    Wait Until Element Is Visible       ${incident_in_table}
    Element Should Not Be Visible       popup-generic
    Click Element                       ${incident_in_table}
    Wait Until Element Is Visible       popup-generic
    Element Should Be Visible           css=span.valign

Close Popup
    Click Element                       ${popup_close}
    Wait Until Element Is Not Visible   popup-generic
    Element Should Not Be Visible       popup-generic

Verify Current Incidents
    ${api} =    Get KPIs                    ${CURRENT_INCIDENTS}
    ${expected} =    Prepare Response       ${api}    incidences
    ${web} =    Get Text                    ${global_incidents}
    Should Be Equal As Strings              ${web}     ${expected}

Verify Current Matching Index
    ${api} =    Get KPIs                    ${CURRENT_MI}
    ${expected} =    Prepare Response       ${api}    incidences_match
    ${web} =    Get Text                    ${global_mi}
    Should Be Equal As Strings              ${web}     ${expected}

Order By
    [Arguments]                                     ${criteria}    ${order}
    Run Keyword If    "${criteria}" == "name"       Select From List By Value    //*[@id="sortincidences"]    title
    Run Keyword If    "${criteria}" == "type"       Select From List By Value    //*[@id="sortincidences"]    name
    Run Keyword If    "${criteria}" == "date"       Select From List By Value    //*[@id="sortincidences"]    start_time
    Run Keyword If    "${order}" == "desc"              Click Element    ${table_desc_button}
    Run Keyword If    "${order}" == "asc"               Click Element    ${table_asc_button}

Get Web Values
    [Arguments]                                     ${criteria}    ${order}
    Wait Until Element is Visible                   css=div.table_on_hover
    Order By                                        ${criteria}    ${order}
    ${count} =   Get Matching Xpath Count           //*[@id="incidents_table"]/div
    ${values_list} =    Create List
    :FOR    ${index}     IN RANGE     1             ${count} + 1
    \    ${path} =    Set Variable If
    ...     "${criteria}" == "name"                 //*[@id="incidents_table"]/div[${index}]/div[1]
    ...     "${criteria}" == "type"                 //*[@id="incidents_table"]/div[${index}]/div[2]
    ...     "${criteria}" == "impact"               //*[@id="incidents_table"]/div[${index}]/div[3]
    ...     "${criteria}" == "date"                 //*[@id="incidents_table"]/div[${index}]/div[4]
    \    ${value} =   Get Text    ${path}
    \    Append To List    ${values_list}           ${value}
    [Return]    ${values_list}

Validate Sorting
    [Arguments]                                         ${criteria}     ${order}
    ${api} =    Get KPIs                                ${INCIDENTS_TABLE}
    ${expected} =    Prepare Incidents Table Response   ${api}    ${criteria}    ${order}
    ${web} =    Get Web Values                          ${criteria}    ${order}
    Lists Should Be Equal                               ${web}    ${expected}

Validate Sorting*
    [Arguments]                                         ${criteria}    ${order}
    ${api} =    Get KPIs                                ${INCIDENTS_TABLE}
    ${expected} =    Prepare Incidents Table Response   ${api}    ${criteria}    ${order}
    ${web} =    Get Impact Web Values                   ${order}
    Lists Should Be Equal                               ${web}    ${expected}

Get Impact Web Values
    [Arguments]                                     ${order}
    Wait Until Element is Visible                   css=div.table_on_hover
    ${count} =   Get Matching Xpath Count           //*[@id="incidents_table"]/div
    ${values_list}    Create List
    Select From List By Value                       //*[@id="sortincidences"]    impact
    Run Keyword If    "${order}" == "desc"          Click Element    ${table_desc_button}
    Run Keyword If    "${order}" == "asc"           Click Element    ${table_asc_button}
    :FOR    ${index}     IN RANGE     1             ${count} + 1
    \       ${a} =    Get Webelement                //*[@id="incidents_table"]/div[${index}]/div[3]/div[1]
    \       ${acolor} =   Call Method               ${a}    value_of_css_property    background
    \       ${b} =    Get Webelement                //*[@id="incidents_table"]/div[${index}]/div[3]/div[2]
    \       ${bcolor} =   Call Method               ${b}    value_of_css_property    background
    \       ${c} =    Get Webelement                //*[@id="incidents_table"]/div[${index}]/div[3]/div[3]
    \       ${ccolor} =   Call Method               ${c}    value_of_css_property    background
    \       ${d} =    Get Webelement                //*[@id="incidents_table"]/div[${index}]/div[3]/div[4]
    \       ${dcolor} =   Call Method               ${d}    value_of_css_property    background
    \       ${e} =    Get Webelement                //*[@id="incidents_table"]/div[${index}]/div[3]/div[5]
    \       ${ecolor} =   Call Method               ${e}    value_of_css_property    background
    \       ${color_list} =    Create List          ${acolor}    ${bcolor}    ${ccolor}    ${dcolor}    ${ecolor}
    \       ${count} =    Count Values In List      ${color_list}    rgb(255, 255, 0) none repeat scroll 0% 0% / auto padding-box border-box
    \       Append To List    ${values_list}        ${count}
    [Return]     ${values_list}

Verify Impact
    ${api} =    Get KPIs                    ${SPECIFIC_INCIDENT}
    ${a} =    Get Webelement                ${popup_incident_impact}/div[1]
    ${acolor} =   Call Method               ${a}    value_of_css_property    background
    ${b} =    Get Webelement                ${popup_incident_impact}/div[2]
    ${bcolor} =   Call Method               ${b}    value_of_css_property    background
    ${c} =    Get Webelement                ${popup_incident_impact}/div[3]
    ${ccolor} =   Call Method               ${c}    value_of_css_property    background
    ${d} =    Get Webelement                ${popup_incident_impact}/div[4]
    ${dcolor} =   Call Method               ${d}    value_of_css_property    background
    ${e} =    Get Webelement                ${popup_incident_impact}/div[5]
    ${ecolor} =   Call Method               ${e}    value_of_css_property    background
    ${color_list} =    Create List          ${acolor}    ${bcolor}    ${ccolor}    ${dcolor}    ${ecolor}
    ${count} =    Count Values In List      ${color_list}    rgb(255, 255, 0) none repeat scroll 0% 0% / auto padding-box border-box
    Should Be Equal As Integers             ${count}    ${api[0]["impact"]}

Verify Private Layers Menu
    Verify Icon and Label    layermatch     ${mi_icon_xpath}        ${mi_label}         ${mi_label_xpath}
    Verify Icon and Label    layerdensity   ${density_icon_xpath}   ${density_label}    ${density_label_xpath}
    Verify Icon and Label    layernumber    ${number_icon_xpath}    ${number_label}     ${number_label_xpath}
    Verify Icon and Label    layerheatmap   ${heatmap_icon_xpath}   ${heatmap_label}    ${heatmap_label_xpath}
    Verify Icon and Label    layerposition  ${position_icon_xpath}  ${position_label}   ${position_label_xpath}

Verify Header Of Element Popup
    ${api} =    Get KPIs                    ${SPECIFIC_INCIDENT}
    Element Text Should Be                  ${popup_header}    ${api[0]["title"]}

Verify Type
    ${api} =    Get KPIs                    ${SPECIFIC_INCIDENT}
    ${expected} =    Prepare Response       ${api}    name
    Element Text Should Be                  ${popup_incident_type}    ${expected}

Verify Date
    ${api} =    Get KPIs                    ${SPECIFIC_INCIDENT}
    ${expected} =    Prepare Response       ${api}    start_time
    ${web} =    Get Text                    ${popup_incident_date}
    Should Be Equal                         ${web}    ${expected}

Verify Description
    ${api} =    Get KPIs                    ${SPECIFIC_INCIDENT}
    ${expected} =    Prepare Response       ${api}    description
    ${web} =    Get Text                    ${popup_incident_description}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Header Of Area Popup
    ${api} =    Get KPIs                    ${AREA_NAME}
    Element Text Should Be                  ${popup_header}    ${api[0]["area_name"]}

Verify Current Incidents By Area
    ${api} =    Get KPIs                    ${SPECIFIC_AREA}
    ${expected} =    Prepare Response       ${api}    incidences
    ${web} =    Get Text                    ${popup_area_incidents}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Current Matching Index By Area
    ${api} =    Get KPIs                    ${AREA_MI}
    ${expected} =    Prepare Response       ${api}    incidences_match
    ${web} =    Get Text                    ${popup_area_mi}
    Should Be Equal As Strings              ${web}    ${expected}
