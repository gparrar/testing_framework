** Settings ***
Documentation       A test suite To test Actions and Actions Log API.
...
...                 This test uses a library to access the API via Thrift located in ${root}/libraries
Resource            ../../keywords/keywords_commons.robot
Resource            ../../keywords/service_actions/keywords_actions.robot

*** Test Cases ***
Verify is not possible to Register An Action Group With Invalid Group Name
    [tags]                                                      high
    ${name} =       Create A Bin                                ci.wocs3.com:8082
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot*group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u"Name must only contain alphanumeric and '., -, _' characters")
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    ' '    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u"Name must only contain alphanumeric and '., -, _' characters")
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u"Name must only contain alphanumeric and '., -, _' characters")

Verify is not possible to Register An Action Group With Invalid URLs
    [tags]                                                      high
    ${name} =       Create A Bin                                ci.wocs3.com:8082
    # Invalid Private URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "semaforos/apagar/", "private_url": "http//ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u\'Error: 400 {"upstream_url":"upstream_url is not a url"}\\n\')
    # Invalid Public URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "semaforos*apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u\'Error: 400 {"request_path":"must only contain alphanumeric and \\\'., -, _, ~, \\\\/, %\\\' characters","name":"name must only contain alphanumeric and \\\'., -, _, ~\\\' characters"}\\n\')
    # Empty Private URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "semaforos/apagar", "private_url": ""}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u'Redirection with empty url passed')
    # Empty Public URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u'Redirection with empty url passed')
    # Null Public URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": null, "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u'Redirection with null url passed')
    # Null Private URL
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "semaforos/apagar", "private_url": null}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u'Redirection with null url passed')
    ${exception} =      Run Keyword And Ignore Error            GET Action    ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal                           404

Register An Action Group
    [tags]                                  critical
    ${name} =       Create A Bin            ci.wocs3.com:8082
    ${name2} =      Create A Bin            ci.wocs3.com:8082
    ${name3} =      Create A Bin            ci.wocs3.com:8082
    ${name4} =      Create A Bin            ci.wocs3.com:8082
    ${name5} =      Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Configure Actions                       robot-group    [{"public_url": "semaforos/encender", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    Configure Actions                       robot.group    [{"public_url": "semaforos/cambiar", "private_url": "http://ci.wocs3.com:8082/${name3}"}]
    Configure Actions                       robot_group_public_slash    [{"public_url": "semaforos/mover/", "private_url": "http://ci.wocs3.com:8082/${name4}"}]
    Configure Actions                       robot_group_private_slash    [{"public_url": "semaforos/reiniciar", "private_url": "http://ci.wocs3.com:8082/${name5}/"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot-group/semaforos/encender
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot.group/semaforos/cambiar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group_public_slash/semaforos/mover
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group_private_slash/semaforos/reiniciar
    Response Status Code Should Equal       200 OK
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/apagar
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name2}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot-group/semaforos/encender
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name3}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot.group/semaforos/cambiar
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name4}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group_public_slash/semaforos/mover
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name5}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group_private_slash/semaforos/reiniciar
    Delete Actions                          robot_group
    Delete Actions                          robot-group
    Delete Actions                          robot.group
    Delete Actions                          robot_group_public_slash
    Delete Actions                          robot_group_private_slash

Get Action Groups
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    ${actions} =    Get Actions
    Should Contain                          ${actions}    robot_group
    Should Contain                          ${actions["robot_group"]}    robot_group~semaforos~apagar

Delete An Action Group
    [tags]                                  functional
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Configure Actions                       robot-group    [{"public_url": "semaforos/encender", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Configure Actions                       robot.group    [{"public_url": "semaforos/cambiar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Delete Actions                          robot_group
    Delete Actions                          robot-group
    Delete Actions                          robot.group
    Run Keyword And Ignore Error            GET Action    ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       404
    Run Keyword And Ignore Error            GET Action    ${SERVER}    robot-group/semaforos/encender
    Response Status Code Should Equal       404
    Run Keyword And Ignore Error            GET Action    ${SERVER}    robot.group/semaforos/cambiar
    Response Status Code Should Equal       404

Verify Redirection of Methods
    [tags]                                  medium
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    PUT Action                              ${SERVER}    robot_group/semaforos/apagar    {}
    POST Action                             ${SERVER}    robot_group/semaforos/apagar    {}
    DELETE Action                           ${SERVER}    robot_group/semaforos/apagar
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name}
    Should Be Equal                         ${requests[0]["method"]}    DELETE
    Should Be Equal                         ${requests[1]["method"]}    POST
    Should Be Equal                         ${requests[1]["raw"]}       {}
    Should Be Equal                         ${requests[2]["method"]}    PUT
    Should Be Equal                         ${requests[2]["raw"]}       {}
    Should Be Equal                         ${requests[3]["method"]}    GET

Update an Action Group With the Same Amount of Actions
    [tags]                                  medium
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/apagar
    ${name2} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name2}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/apagar
    Delete Actions                          robot_group

Register An Action Group With Multiple Actions
    [tags]                                  medium
    ${name} =       Create A Bin            ci.wocs3.com:8082
    ${name2} =      Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}, {"public_url": "semaforos/encender", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group/semaforos/encender
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/apagar
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name2}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/encender
    Delete Actions                          robot_group

Register Multiple Actions With Same Public URL (Same Action Group)
    [tags]                                                      high
    ${name} =       Create A Bin                                ci.wocs3.com:8082
    ${name2} =       Create A Bin                               ci.wocs3.com:8082
    ${exception} =      Run Keyword And Ignore Error            Configure Actions    robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}, {"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    Should Contain                                              ${exception}    WrongParametersException: WrongParametersException(message=u'Redirection with duplicated url passed')
    ${exception} =      Run Keyword And Ignore Error            GET Action    ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal                           404

Register Multiple Actions With Same Public URL (Different Action Groups)
    [tags]                                  high
    ${name} =       Create A Bin            ci.wocs3.com:8082
    ${name2} =       Create A Bin           ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    Configure Actions                       robot_group2    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    GET Action                              ${SERVER}    robot_group2/semaforos/apagar
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/apagar
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name2}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group2/semaforos/apagar
    Delete Actions                          robot_group
    Delete Actions                          robot_group2

Register An Action Group With Multiple Actions Same Endpoint
    [tags]                                  medium
    ${name} =       Create A Bin            ci.wocs3.com:8082
    ${name2} =       Create A Bin            ci.wocs3.com:8082

    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}, {"public_url": "semaforos/encender", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group/semaforos/encender
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name}
    Log    ${requests}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/encender
    Should Contain                          ${requests[1]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[1]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/apagar
    Delete Actions                          robot_group

Update An Action Group With Less Actions
    [tags]                                  medium
    ${name} =       Create A Bin            ci.wocs3.com:8082
    ${name2} =      Create A Bin            ci.wocs3.com:8082
    #Configure Action Group with 2 redirections
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}, {"public_url": "semaforos/encender", "private_url": "http://ci.wocs3.com:8082/${name2}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group/semaforos/encender
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/apagar
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name2}
    Evaluate API Request                    @{requests}    ${SERVER}    robot_group/semaforos/encender
    # Update Action Group with 1 redirection
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name2}
    Call Unexisting Action                  ${SERVER}    semaforos/encender
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    Delete Actions                          robot_group

Register An Action Group (multiple calls)
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    GET Action                              ${SERVER}    robot_group/semaforos/apagar
    Response Status Code Should Equal       200 OK
    @{requests} =       Get API Requests    ci.wocs3.com:8082    ${name}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[0]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/apagar
    Should Contain                          ${requests[1]["headers"]["X-Forwarded-Host"]}      ${SERVER}
    Should Contain                          ${requests[1]["headers"]["X-Forwarded-Prefix"]}    /actions/robot_group/semaforos/apagar
    Delete Actions                          robot_group

# Action Log
Verify is not possible to Set Action Log with Invalid Internal ID Header
    [tags]                                              high
    ${name} =       Create A Bin                        ci.wocs3.com:8082
    Configure Actions                                   robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action With All Headers                         ${SERVER}    robot_group/semaforos/apagar    abc    Description    extra_info    1
    ${log} =        Run Keyword And Ignore Error        Get Action Log          ${SERVER}    abc
    Response Status Code Should Equal                   404
    Delete Actions                                      robot_group

Verify is not possible to Set Action Log with Description Longer Than Max Permitted Lenght
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group_long    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action With All Headers             ${SERVER}    robot_group_long/semaforos/apagar    123    This description is longer than sixty four characteres of length    extra_info    1
    ${log} =        Get Action Log          ${SERVER}    123
    Response Status Code Should Equal       200 OK
    Run Keyword And Ignore Error            Should Be Equal     ${log[0]["readable_description"]}    This description is longer than sixty four characteres of lengt
    Delete Actions                          robot_group_long
    Fail                                    Value was not capped to 64 char

Verify is not possible to Set Action Log with Extra Info Longer Than Max Permitted Lenght
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group_long    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action With All Headers             ${SERVER}    robot_group_long/semaforos/apagar    1234    Description    test_maximum_lenght_for_extra_info    1
    Response Status Code Should Equal       200 OK
    ${log} =        Get Action Log          ${SERVER}    1234
    Run Keyword And Ignore Error            Should Be Equal     ${log[0]["extra_request_info"]}    This description is longer than sixty four characteres of lengt
    Delete Actions                          robot_group_long
    Fail                                    Value was not capped to 32 char

Verify is not possible to Set Action Log with Invalid Expiration Time Header
    [tags]                                  high
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group_invalid_time    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    # Expiration Time as Null
    GET Action With All Headers             ${SERVER}    robot_group_invalid_time/semaforos/apagar    12345    Description    extra_info    null
    Response Status Code Should Equal       200 OK
    # Negative Expiration Time
    GET Action With All Headers             ${SERVER}    robot_group_invalid_time/semaforos/apagar    12345    Description    extra_info    -5
    ${log} =        Get Action Log          ${SERVER}    12345
    Response Status Code Should Equal       200 OK
    Delete Actions                          robot_group_invalid_time

Set Action Log With All Headers
    [tags]                                  critical
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action With All Headers             ${SERVER}    robot_group/semaforos/apagar    123456    description    extra_info    1
    Response Status Code Should Equal       200 OK
    ${log} =        Get Action Log          ${SERVER}    123456
    Should Be Equal                         ${log[0]["url"]}                                       /actions/robot_group/semaforos/apagar
    Should Be Equal                         ${log[0]["readable_description"]}                      description
    Should Be Equal                         ${log[0]["extra_request_info"]}                        extra_info
    Should Be Equal As Integers             ${log[0]["expiration_time_in_seconds"]}                1

Set Action Log Without Internal ID Header
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action Without Internal ID Header   ${SERVER}    robot_group/semaforos/apagar    Description    extra_info    1
    Response Status Code Should Equal       200 OK
    @{requests} =                           Get API Requests    ci.wocs3.com:8082    ${name}
    Log    ${requests}
    Delete Actions                          robot_group

Set Action Log Without Description Header
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action Without Description Header   ${SERVER}    robot_group/semaforos/apagar    1234567    extra_info    1
    ${log} =        Get Action Log          ${SERVER}    1234567
    Should Be Equal                         ${log[0]["readable_description"]}    ${None}
    Delete Actions                          robot_group

Set Action Log Without Extra Info Header
    [tags]                                  low
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action Without Extra Info Header    ${SERVER}    robot_group/semaforos/apagar    12345678    Description    1
    ${log} =        Get Action Log          ${SERVER}    12345678
    Should Be Equal                         ${log[0]["extra_request_info"]}    ${None}
    Response Status Code Should Equal       200 OK
    Delete Actions                          robot_group

Set Action Log Without Expiration Time Header
    [tags]                                          low
    ${name} =       Create A Bin                    ci.wocs3.com:8082
    Configure Actions                               robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action Without Expiration Time Header       ${SERVER}    robot_group/semaforos/apagar    123456789    Description    extra_info
    Response Status Code Should Equal               200 OK
    ${log} =        Get Action Log                  ${SERVER}    123456789
    Should Be Equal As Integers                     ${log[0]["expiration_time_in_seconds"]}    600
    Delete Actions                                  robot_group

Verify Action Log Properly Expires
    [tags]                                  critical
    ${name} =       Create A Bin            ci.wocs3.com:8082
    Configure Actions                       robot_group    [{"public_url": "semaforos/apagar", "private_url": "http://ci.wocs3.com:8082/${name}"}]
    GET Action With All Headers             ${SERVER}    robot_group/semaforos/apagar    1234567890    description    extra_info    5
    ${log} =        Get Action Log          ${SERVER}    1234567890
    Should Be Equal As Integers             ${log[0]["expiration_time_in_seconds"]}                5
    Sleep                                   6
    ${log} =        Get Action Log          ${SERVER}    1234567890
    ${expected} =    Create List            []
    Should Be Equal As Strings              ${log}    []
    Delete Actions                          robot_group
