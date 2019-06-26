*** Settings ***
Documentation     A resource file containing WiKi home page specific keywords.
...
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Resource          ../service_influence_zone/keywords_influence_zone.robot
Resource          ../keywords_commons.robot
Variables         ../../variables/service_custom_object/${ENV}_variables.py

*** Keywords ***
# Objects
Create Object
# TODO refactor with Create Object Type
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    POST                                    /mb/objects
    Response Status Code Should Equal       201

Create Object Type
      [Arguments]                             ${payload}
      Authentication
      Set Request Body                        ${payload}
      Set Request Header                      Content-Type    application/json
      POST                                    /mb/objects
      Response Status Code Should Equal       201

Create Exiting Object
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       409
    Response Body Should Contain            {"message": "There is already an object with type: robot_custom_object"}

Create Object Using Bad Request
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       400
    Response Body Should Contain            {"message": "Invalid JSON: object_type must match pattern

Create Object With Empty Name
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       400
    Response Body Should Contain            {"message": "Invalid JSON: object_type cannot be an empty string"}

Create Object With Invalid JSON
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       400
    Response Body Should Contain            {"message": "Invalid JSON"}

Create Object With Long Name
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       400
    Response Body Should Contain            {"message": "object_type is longer than expected max lenght (32)"}

Create Object With Long Object Type
    [Arguments]                             ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects
    Response Status Code Should Equal       400
    Response Body Should Contain            {"message": "name is longer than expected max lenght (32)"}


Delete Object
    [Arguments]                             ${object_type}
    Authentication
    DELETE                                  /mb/objects/${object_type}

Get Object Schema
    [Arguments]                             ${object_type}
    Authentication
    GET                                     /mb/objects/${object_type}/schema
    Response Status Code Should Equal       200 OK

Get Unexisting Object Schema
    [Arguments]                             ${object_type}
    Authentication
    Next Request Should Not Succeed
    GET                                     /mb/objects/${object_type}/schema
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "Object robot_custom_object_unexisting doesn't exist."}

Get Object Stub
    [Arguments]                             ${object_type}
    Authentication
    GET                                     /mb/objects/${object_type}/stub
    Response Status Code Should Equal       200 OK

Get Unexisting Object Stub
    [Arguments]                             ${object_type}
    Authentication
    Next Request Should Not Succeed
    GET                                     /mb/objects/${object_type}/stub
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "Object robot_custom_object_unexisting doesn't exist."}


Get Objects
    Authentication
    GET                                     /mb/objects
    Response Status Code Should Equal       200 OK


Update Object Schema
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    PUT                                     /mb/objects/${object_type}/schema
    Response Status Code Should Equal       200 OK

Update Object Schema With Invalid JSON
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    PUT                                     /mb/objects/${object_type}/schema
    Response Status Code Should Equal       400 BAD REQUEST
    Response Body Should Contain            {"message": "Invalid JSON"}


# Instances
Create Object Instance
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    POST                                    /mb/objects/${object_type}/instances
    Response Status Code Should Equal       201 CREATED

Create Object Instance With Invalid JSON
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects/${object_type}/instances
    Response Status Code Should Equal       400 BAD REQUEST

Create Object Instance For Unexistent Object
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects/${object_type}/instances
    Response Status Code Should Equal       404

Create Object Instance Unexistent Reference
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects/${object_type}/instances
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "The internalid of the reference "}

Delete Object Instance by Internal ID
    [Arguments]                             ${internal_id}
    Authentication
    DELETE                                  /mb/objects/instances/${internal_id}

Delete Object Instance by Unexistent Internal ID
    [Arguments]                             ${internal_id}
    Authentication
    Next Request Should Not Succeed
    DELETE                                  /mb/objects/instances/${internal_id}
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "There is no instance with id 5000"}

Delete Other Instances
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    POST                                    /mb/objects/${object_type}/instances/actions/delete_others

Delete Other Instances With Invalid JSON
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects/${object_type}/instances/actions/delete_others
    Response Status Code Should Equal       400 BAD REQUEST

Delete Other Unexistent Instances
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Next Request Should Not Succeed
    POST                                    /mb/objects/${object_type}/instances/actions/delete_others
    Response Status Code Should Equal       404


Get Object Instances by Core ID
    [Arguments]                             ${object_type}  ${source}  ${core_id}
    Authentication
    GET                                     /mb/objects/${object_type}/instances/core_id/${source}/${core_id}
    Response Status Code Should Equal       200 OK

Get Object Instances by Unexistent Core ID
    [Arguments]                             ${object_type}  ${source}  ${core_id}
    Authentication
    Next Request Should Not Succeed
    GET                                     /mb/objects/${object_type}/instances/core_id/${source}/${core_id}
    Response Status Code Should Equal       404
    Response Body Should Contain            "message": "There is no instance with id simo#190239BW"

Get Object Instance by External ID
    [Arguments]                             ${object_type}  ${external_id_key}  ${external_id}
    Authentication
    GET                                     /mb/objects/${object_type}/instances/external/${external_id_key}/${external_id}
    Response Status Code Should Equal       200 OK

Get Object Instance by Unexistent External ID
    [Arguments]                             ${object_type}  ${external_id_key}  ${external_id}
    Authentication
    Next Request Should Not Succeed
    GET                                     /mb/objects/${object_type}/instances/external/${external_id_key}/${external_id}

Get Object Instance by Internal ID
    [Arguments]                             ${internal_id}
    Authentication
    GET                                     /mb/objects/instances/${internal_id}
    Response Status Code Should Equal       200 OK

Get Object Instance by Unexistent Internal ID
    [Arguments]                             ${internal_id}
    Authentication
    GET                                     /mb/objects/instances/${internal_id}
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "There is no instance with id 5000"}


Update Object Instance by Core ID
    [Arguments]                             ${object_type}  ${source}  ${core_id}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    PUT                                     /mb/objects/${object_type}/instances/core_id/${source}/${core_id}
    Response Status Code Should Equal       200 OK

Update Object Instance by External ID
    [Arguments]                             ${object_type}  ${external_id_key}  ${external_id}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    PUT                                     /mb/objects/${object_type}/instances/external/${external_id_key}/${external_id}
    Response Status Code Should Equal       200 OK

Update Object Instance by Internal ID
    [Arguments]                             ${internal_id}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    PUT                                     /mb/objects/instances/${internal_id}
    Response Status Code Should Equal       200 OK

Get Instance Internal ID
    [Arguments]                             ${object_type}  ${external_id_key}  ${external_id}
    Get Object Instance by External ID      ${object_type}  ${external_id_key}  ${external_id}
    ${body} =                               Get Response Body
    ${object} =         Evaluate            json.loads('''${body}''')    json
    ${internal_id} =    Set Variable        ${object["id"]}
    [return]                                ${internal_id}

# Visualizations
Get Object Visualizations
    [Arguments]                             ${object_type}
    Authentication
    GET                                     /mb/objects/${object_type}/visualization
    Response Status Code Should Equal       200 OK

Get Unexistent Object Visualizations
    [Arguments]                             ${object_type}
    Authentication
    GET                                     /mb/objects/${object_type}/visualization
    Response Status Code Should Equal       404


Update Object Visualization Map
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    Run Keyword And Ignore Error            PUT    /mb/objects/${object_type}/visualization/map

Update Object Visualization Popup
    [Arguments]                             ${object_type}  ${payload}
    Authentication
    Set Request Body                        ${payload}
    Set Request Header                      Content-Type    application/json
    PUT                                     /mb/objects/${object_type}/visualization/popup

Get Instances On Influence Zone Service
    [Arguments]                             ${payload}
    Get Influence                           ${payload}
    ${body} =                               Get Response Body
    Log    ${body}
    ${influence} =         Evaluate         json.loads('''${body}''')    json
    [return]                                ${influence}

Verify Position
    [Arguments]                             ${position}
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    Should Be Equal As Strings              ${json["instances"][0]["position"]}    ${position}

Verify ID
    [Arguments]                             ${id}
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    Should Be Equal As Strings              ${json["instances"][0]["id"]}    ${id}

Verify Response Is Empty
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    Should Be Equal As Strings              ${json["instances"]}    []

Verify All Expected Instances
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    Length Should Be                        ${instances}    4
    Should Be Equal                         ${json["instances"][0]["tags"]["name"]}    CUSTOM INSTANCE INFLUENCER TEST 0
    Should Be Equal                         ${json["instances"][1]["tags"]["name"]}    CUSTOM INSTANCE INFLUENCER TEST 1
    Should Be Equal                         ${json["instances"][2]["tags"]["name"]}    CUSTOM INSTANCE INFLUENCER TEST 2
    Should Be Equal                         ${json["instances"][3]["tags"]["name"]}    CUSTOM INSTANCE INFLUENCER TEST 3

Verify Instances Influence Zone
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    Length Should Be                        ${instances}    2
    Should Be Equal As Strings              ${instances[0]["influence_zone"]["coordinates"]}    [[[-66.8813323975, 11.469581643], [-67.8813323975, 9.469581643], [-65.8813323975, 9.469581643], [-66.8813323975, 11.469581643]]]
    Should Be Equal As Strings              ${instances[1]["influence_zone"]["coordinates"]}    [[[-65.8813323975, 9.469581643], [-65.8813323975, 11.469581643], [-67.8813323975, 11.469581643], [-67.8813323975, 9.469581643], [-65.8813323975, 9.469581643]]]

Verify Only The Survivor Is Received
    ${body} =                               Get Response Body
    ${json} =      Parse Json               ${body}
    @{instances} =                          Set Variable    ${json["instances"]}
    Should Be Equal                         ${instances[0]["tags"]["name"]}    CUSTOM INSTANCE INFLUENCER TEST 3
    Length Should Be                        ${instances}    1

Delete Instance By Extenal ID
    [Arguments]                             ${object_type}  ${external_id_key}  ${external_id}
    Get Object Instance by External ID      ${object_type}  ${external_id_key}  ${external_id}
    ${body} =                               Get Response Body
    ${object} =         Evaluate            json.loads('''${body}''')    json
    ${internal_id} =    Set Variable        ${object["id"]}
    Delete Object Instance by Internal ID   ${object["id"]}

Delete Remaining Objects
    Delete Object                           robot_object_type_longer_max_char
    Delete Object                           robot_name_longer_max_char
    Delete Object                           robot_badreference_object
    Delete Object                           robot_coreunexistent_object
    Delete Object                           robot_longinstance_object
    Delete Instance By Extenal ID           robot_longinstance_object    test_id    test_maximum_lenght_for_external_id
    Delete Instance By Extenal ID           robot_coreunexistent_object    test_id    TEST-No-reference
