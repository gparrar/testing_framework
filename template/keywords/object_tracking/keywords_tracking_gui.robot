*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           ../../libraries/object_tracking/tracking_library.py
Resource          ../keywords_commons.robot
Variables         ../../variables/global_paths.py
Variables         ../../variables/global_${ENV}.py
Variables         ../../variables/object_tracking/${ENV}_variables.py


*** Keywords ***
Open Package
    Click Element                           ${menu_button}
    Wait Until Element is Visible           ${left_menu}
    Assign Id To Element                    ${areas_table}    areas_table
    Assign Id To Element                    ${private_layers}    private_layers

Setup Tracking
    Open Browser To Login Page
    Log In
    Open Package

Teardown Tracking
    Log Out
    Close Browser

Verify Left Menu
    Verify Icon and Label    menuicon       ${icon_xpath}    ${menu_title}    ${label_xpath}

Validate Tooltip
    Mouse Over                              ${label_xpath}
    Element Text Should Be                  ${menu_button}/div[3]/span    ${menu_tooltip}

Validate Title
    Element Text Should Be                  ${menu_title_path}    ${title}

Verify Icon and Label
    [Arguments]                         ${icon}    ${icon_path}    ${label}    ${label_path}
    Wait Until Element is Visible       ${icon_path}
    Element should be visible           ${icon_path}
    Page should contain image           ${icon_path}
    Element Text Should Be              ${label_path}    ${label}
    ${img src}=    Get element attribute    ${icon_path}@src
    Create HTTP Context                     ${SERVER}  ${SCHEME}
    Set Basic Auth                          ${VALID USER}    ${VALID PASSWORD}
    GET                                     ${img src}
    ${response}                             Get Response Status
    Should be equal as Strings    ${response}    200 OK
    Download a file    ${icon}    ${img src}
    Compare Images     ${ROBOT_DIR}/resources/object_tracking/images/${icon}.png    /tmp/${icon}    0.1

Validate Total Number of Elements
    ${api} =    Get KPIs                    ${TOTAL_ELEMENTS}
    ${expected} =    Prepare Response       ${api}    sum
    ${web} =    Get Text                    ${global_total}
    Should Be Equal As Strings              ${web}    ${expected}

Validate Total Number of Active Elements
    ${api} =    Get KPIs                    ${ACTIVE_ELEMENTS}
    ${expected} =    Prepare Response       ${api}    elements
    ${web} =    Get Text                    ${global_active}
    Should Be Equal As Strings              ${web}    ${api[0]["elements"]}

Validate Matching Index
    ${api} =    Get KPIs                    ${MATCHING_INDEX}
    ${expected} =    Prepare Response       ${api}    elements_match
    ${web} =    Get Text                    ${global_mi}
    Should Be Equal As Strings              ${web}    ${expected}

Order By
    [Arguments]                                     ${criteria}    ${order}
    Run Keyword If    "${criteria}" == "area"       Select From List By Value    ${sort_selector}    area_name
    Run Keyword If    "${criteria}" == "total"      Select From List By Value    ${sort_selector}    elementsall
    Run Keyword If    "${criteria}" == "active"     Select From List By Value    ${sort_selector}    elements
    Run Keyword If    "${criteria}" == "density"    Select From List By Value    ${sort_selector}    density
    Run Keyword If    "${criteria}" == "matching"   Select From List By Value    ${sort_selector}    match
    Run Keyword If    "${order}" == "desc"          Click Element    ${table_desc_button}
    Run Keyword If    "${order}" == "asc"           Click Element    ${table_asc_button}

Get Web Values
    [Arguments]                                     ${criteria}    ${order}
    Wait Until Element is Visible                   css=div.table_on_hover
    Order By                                        ${criteria}    ${order}
    ${count} =   Get Matching Xpath Count           //*[@id="areas_table"]/div
    ${values_list} =    Create List
    :FOR    ${index}     IN RANGE     1             ${count} + 1
    \    ${path} =    Set Variable If
    ...     "${criteria}" == "area"                 //*[@id="areas_table"]/div[${index}]/div[1]/div[2]/p
    ...     "${criteria}" == "total"                //*[@id="areas_table"]/div[${index}]/div[2]/p
    ...     "${criteria}" == "active"               //*[@id="areas_table"]/div[${index}]/div[3]/p
    ...     "${criteria}" == "density"              //*[@id="areas_table"]/div[${index}]/div[4]/p
    ...     "${criteria}" == "matching"             //*[@id="areas_table"]/div[${index}]/div[5]/div/div/p/span[1]
    \    ${value} =   Get Text                      ${path}
    \    Append To List    ${values_list}           ${value}
    [Return]    ${values_list}

Validate Sorting
    [Arguments]                                     ${criteria}     ${order}
    ${api} =    Get KPIs                            ${AREAS_TABLE_QUERY}
    ${expected} =    Prepare Areas Table Response   ${api}    ${criteria}    ${order}
    ${web} =    Get Web Values                      ${criteria}    ${order}
    Lists Should Be Equal                           ${web}   ${expected}

Open Area Popup
    Element Should Not Be Visible           popup-generic
    Wait Until Element Is Visible           ${element_in_table}
    Click Element                           ${element_in_table}
    Wait Until Element Is Visible           popup-generic
    Sleep    2s
    Element Should Be Visible               css=span.valign

Close Popup
    Click Element                           ${popup_close}
    Element Should Not Be Visible           popup-generic

Verify Header Of Area Popup
    ${api} =    Get KPIs                    ${AREA_HEADER}
    ${area} =    Evaluate                   str(round(${api[0]["shape_area"]},2))
    Element Text Should Be                  ${popup_header}    ${api[0]["area_name"]}\n[${area}km]

Verify Header Of Element Popup
    ${api} =    Get KPIs                    ${AREA_HEADER}
    ${area} =    Evaluate                   str(round(${api[0]["shape_area"]},2))
    Element Text Should Be                  ${popup_header}    ${api[0]["area_name"]}\n[${area}km]

Verify Area Total Elements
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    elementsall
    ${web} =    Selenium2Library.Get Text   ${popup_area_total}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Area Active Elements
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    elements
    ${web} =    Selenium2Library.Get Text   ${popup_area_active}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Area Density
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    density
    ${web} =    Selenium2Library.Get Text   ${popup_area_density}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Area Matching Index
    ${api} =    Get KPIs                    ${AREA_INFO}
    ${expected} =    Prepare Response       ${api}    elements_match
    ${web} =    Selenium2Library.Get Text   ${popup_area_mi}
    Should Be Equal As Strings              ${web}    ${expected}

Verify Private Layers Menu
    Verify Icon and Label    layermatch     ${mi_icon_xpath}    ${mi_label}    ${mi_label_xpath}
    Verify Icon and Label    layerdensity   ${density_icon_xpath}    ${density_label}    ${density_label_xpath}
    Verify Icon and Label    layernumber    ${number_icon_xpath}    ${number_label}    ${number_label_xpath}
    Verify Icon and Label    layerposition  ${position_icon_xpath}    ${position_label}    ${position_label_xpath}
    Verify Icon and Label    timelapse      ${timelapse_icon_xpath}    ${timelapse_label}    ${timelapse_label_xpath}

Click On Map
    Wait Until Element Is Visible     //*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]
    Click Element    ${number_icon_xpath}
    Wait Until Element Is Visible     //*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]
    Click Element    //*[@id="map"]/div[1]/div[1]/div[2]/div[2]/img[1]
