*** Settings ***
Documentation     A resource file containing WiKi home page specific keywords.
...
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Resource          ../keywords_commons.robot
Variables         ../../variables/service_actions/${ENV}_variables.py
Library           ../../libraries/service_actions/ActionController.py    ${SERVER}    6000

*** Keywords ***
# Requestbin
Create A Bin
    [Arguments]                             ${requestbin}
    Create HTTP Context                     ${requestbin}     http
    POST                                    /api/v1/bins
    ${body} =                               Get Response Body
    ${response} =       Evaluate            json.loads('''${body}''')    json
    ${bin} =            Set Variable        ${response["name"]}
    [return]                                ${bin}

Get API Requests
    [Arguments]                             ${requestbin}     ${name}
    Create HTTP Context                     ${requestbin}  http
    GET                                     /api/v1/bins/${name}/requests
    ${body} =                               Get Response Body
    @{requests} =       Parse Json          ${body}
    [return]                                @{requests}

Evaluate API Request
    [Arguments]                             ${requests}    ${host}    ${action}    ${body}=
    Log  ${requests}
    : FOR   ${request}    in    ${requests}
    \   Log     ${request}
    \   Should Be Equal                     ${request["headers"]["X-Forwarded-Host"]}    ${host}
    \   Should Be Equal                     ${request["headers"]["X-Forwarded-Prefix"]}    /actions/${action}
    \   Should Be Equal                     ${request["raw"]}    ${body}

# Actions
GET Action
    [Arguments]                             ${server}    ${action}
    Authentication
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body

PUT Action
    [Arguments]                             ${server}    ${action}    ${payload}
    Authentication
    Set Request Body                        ${payload}
    PUT                                     /mb/actions/${action}
    ${body} =                               Get Response Body

POST Action
    [Arguments]                             ${server}    ${action}    ${payload}
    Authentication
    Set Request Body                        ${payload}
    POST                                     /mb/actions/${action}
    ${body} =                               Get Response Body

DELETE Action
    [Arguments]                             ${server}    ${action}
    Authentication
    DELETE                                  /mb/actions/${action}
    ${body} =                               Get Response Body

Call Unexisting Action
    [Arguments]                             ${server}    ${action}
    Authentication
    Next Request Should Not Succeed
    GET                                     /mb/actions/${action}
    Response Status Code Should Equal       404


GET Action With All Headers
    [Arguments]                             ${server}    ${action}    ${internalid}=    ${description}=    ${extra_info}=    ${expiration_time}=
    Authentication
    Set Request Header                      X-MB-InstanceID    ${internalid}
    Set Request Header                      X-MB-ReadableDescription    ${description}
    Set Request Header                      X-MB-ExtraRequestInfo    ${extra_info}
    Set Request Header                      X-MB-ExpirationTimeInSeconds    ${expiration_time}
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body

GET Action Without Internal ID Header
    [Arguments]                             ${server}    ${action}    ${description}=    ${extra_info}=    ${expiration_time}=
    Authentication
    Set Request Header                      X-MB-ReadableDescription    ${description}
    Set Request Header                      X-MB-ExtraRequestInfo    ${extra_info}
    Set Request Header                      X-MB-ExpirationTimeInSeconds    ${expiration_time}
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body

GET Action Without Description Header
    [Arguments]                             ${server}    ${action}    ${internalid}=    ${extra_info}=    ${expiration_time}=
    Authentication
    Set Request Header                      X-MB-InstanceID    ${internalid}
    Set Request Header                      X-MB-ExtraRequestInfo    ${extra_info}
    Set Request Header                      X-MB-ExpirationTimeInSeconds    ${expiration_time}
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body


GET Action Without Extra Info Header
    [Arguments]                             ${server}    ${action}    ${internalid}=     ${description}=    ${expiration_time}=
    Authentication
    Set Request Header                      X-MB-InstanceID    ${internalid}
    Set Request Header                      X-MB-ExpirationTimeInSeconds    ${expiration_time}
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body

GET Action Without Expiration Time Header
    [Arguments]                             ${server}    ${action}    ${internalid}=    ${description}=    ${extra_info}=
    Authentication
    Set Request Header                      X-MB-InstanceID    ${internalid}
    Set Request Header                      X-MB-ReadableDescription    ${description}
    Set Request Header                      X-MB-ExtraRequestInfo    ${extra_info}
    GET                                     /mb/actions/${action}
    ${body} =                               Get Response Body

Get Action Log
    [Arguments]                             ${server}    ${internalid}
    Authentication
    GET                                     /mb/objects/instances/${internalid}/actionlog
    ${body}                                 Get Response Body
    ${log} =       Parse Json               ${body}
    [return]                                ${log}

Delete Remaining Groups
    Delete Actions                          robot_group_long
    Delete Actions                          robot_group
    Delete Actions                          robot_group_invalid_time
