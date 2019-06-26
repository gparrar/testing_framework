*** Settings ***
Documentation     A resource file with reusable keywords and variables to test Vehicle Counting Objects.

*** Keywords ***
Verify Counting Point Position
    [Arguments]                             ${expected_name}    ${expected_position}
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    : FOR    ${instance}    IN    @{instances}
    \    ${position} =    Evaluate    json.dumps(${instance["position"]})    json
    \    Run Keyword If    '${instance["tags"]["name"]}' == '${expected_name}'    Should Be Equal As Strings    ${position}    ${expected_position}

Verify Disabled Points Got Not Position
    [Arguments]                             ${name}
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    : FOR    ${instance}    IN    @{instances}
    \    Dictionary Should Not Contain Value           ${instance["tags"]}    ${name}