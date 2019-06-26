*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Resource          ../keywords_commons.robot
Variables         ../../variables/object_tracking/${ENV}_variables.py
Library           ../../libraries/object_tracking/DisableOthers.py    ${SERVER}

*** Keywords ***
Parse Response
    ${body} =                               Get Response Body
    ${dict} =      Parse Json                ${body}
    [Return]                                ${dict}

Verify Element Position
    [Arguments]                             ${expected_name}    ${expected_position}
    ${body} =                               Get Response Body
    ${json} =      Parse Json                ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    : FOR    ${instance}    IN    @{instances}
    \    ${position} =    Evaluate    json.dumps(${instance["position"]})    json
    \    Run Keyword If    '${instance["tags"]["name"]}' == '${expected_name}'    Should Be Equal As Strings    ${position}    ${expected_position}


Verify Disabled Elements Got Not Position
    [Arguments]                             ${name}
    ${body} =                               Get Response Body
    ${json} =      Parse Json                ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    : FOR    ${instance}    IN    @{instances}
    \    Dictionary Should Not Contain Value           ${instance["tags"]}    ${name}

Verify Object Registered Shape
    [Arguments]                             ${expected_shape}
    ${body} =                               Get Response Body
    @{shapes} =      Parse Json               ${body}
    : FOR    ${shape}    IN    @{shapes}
    \    Run Keyword If    '${shape["shape_id"]}' == '${expected_shape}'    Exit For Loop

Re-Enable Disabled Elements
    Open Connection And Login
    Execute Command    docker exec -i mb_mbpostgres_1 psql -U postgres mb_development_db -c "update tracking_elements_mb set enabled = \'True\'"   return_stderr=True    return_rc=True
    Close Connection
