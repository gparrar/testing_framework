*** Settings ***
Documentation                   Black box tests Custom Object API
Resource                        ../../keywords/service_custom_object/keywords_custom_object.robot
Test Setup                      Create HTTP Context     ${SERVER}  ${SCHEME}
Suite Teardown                  Delete Remaining Objects


*** Test Cases ***
Verify It Is Possible To Create Objects
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Core Object", "core": true}
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Verify It Is possible To Create An Object With Null Name
    [Tags]                                  medium
    Create Object                           {"object_type": "null", "name": "Robot Custom Object", "core": false}
    [Teardown]                              Delete Object    null

Try to Create Already Existing Object
    [Tags]                                  high
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Exiting Object                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    [Teardown]                              Delete Object    robot_custom_object

Try To Create An Object With An Invalid Object Type (Special Character)
    [Tags]                                 low
    Create Object Using Bad Request         {"object_type": "robot*special*test", "name": "Robot Custom Object", "core": false}

Try To Create An Object With An Invalid Object Type (White Spaces)
    [Tags]                                  low
    Create Object Using Bad Request         {"object_type": "robot white test", "name": "Robot Custom Object", "core": false}

Try to Create An Object With Empty Object Type
    [Tags]                                  low
    Create Object With Empty Name           {"object_type": "", "name": "Robot Custom Object", "core": false}

Try to Create An Object with an Invalid JSON
    [Tags]                                  high
    # Invalid Key
    Create Object With Invalid JSON         {object_type: "robot_core_object", "name": "Robot Core Object", "core": true}
    # Invalid Value
    Create Object With Invalid JSON         {"object_type": robot_core_object, "name": "Robot Core Object", "core": true}
    # Invalid Boolean
    Create Object With Invalid JSON         {"object_type": "robot_core_object", "name": "Robot Core Object", "core": True}

Try to Create An Object with Object Type Longer Than Max Permitted Lenght
    [Tags]                                  low
    Create Object With Long Name            {"object_type": "robot_object_type_longer_max_char", "name": "Robot Core Object"}

Try to Create An Object with Name Longer Than Max Permitted Lenght
    [Tags]                                  low
    Create Object With Long Object Type     {"object_type": "robot_name_longer_max_char", "name": "Robot Core Object Name Longer than Max Permitted"}

Get Objects
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Get Objects
    [Teardown]                              Delete Object    robot_custom_object

# Schemas
Create Schemas
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Custom Object", "core": true}
    Update Object Schema                    robot_core_object   {"properties":{"cost":{"$ref":"#/currency"},"description":{"$ref":"#/rich_text"},"favicon":{"$ref":"#/url_icon"},"geometry":{"$ref":"#/geometry"},"last_maintenance":{"$ref":"#/date"},"name":{"type":"string"},"profile_picture":{"$ref":"#/url_picture"},"test_id":{"$ref":"#/external_id"},"website":{"$ref":"#/url"},"robot_object":{"$ref":"#/ref"}},"type":"object"}
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                    robot_custom_object   {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Try to Update Schema With An Invalid JSON
    [Tags]                                  high
    # Invalid Key
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema With Invalid JSON  robot_custom_object   {"properties":{name:{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    # Invalid Value
    Update Object Schema With Invalid JSON  robot_custom_object   {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":object}
    [Teardown]                              Delete Object    robot_custom_object

Try to Update a Schema With a Malformed Reference
    [Tags]                                  high
    Create Object                           {"object_type": "robot_badreference_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema With Invalid JSON  robot_badreference_object   {"properties":{"name":{"type":"string"},"test_id":{"ref":"#/external_id"}},"type":"object"}

Get Schemas
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                    robot_custom_object   {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Get Object Schema                       robot_custom_object
    [Teardown]                              Delete Object    robot_custom_object

Try to Get Unexisting Schema
    [Tags]                                  low
    Get Unexisting Object Schema            robot_custom_object_unexisting

Get Stubs
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Get Object Stub                         robot_custom_object
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Core Object", "core": true}
    Get Object Stub                         robot_core_object
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Try to Get Unexisting Stub
    [Tags]                                  low
    Next Request Should Not Succeed
    Get Unexisting Object Stub              robot_custom_object_unexisting

Try to Get Stub of Object without Schema
    [Tags]                                  high
    Create Object                           {"object_type": "no_schema", "name": "Wifi Hotspot", "core": false}
    Get Object Stub                         no_schema
    [Teardown]                              Delete Object    no_schema

Try to Get Stub of Object with Empty Schema
    [Tags]                                  high
    Create Object                           {"object_type": "empty_schema", "name": "Wifi Hotspot", "core": false}
    Update Object Schema                    empty_schema  {}
    Get Object Stub                         empty_schema
    [Teardown]                              Delete Object    empty_schema

Update Schema
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                    robot_custom_object   {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    [Teardown]                              Delete Object    robot_custom_object

# Instances
Try to Create An Instance with An Invalid JSON
    [Tags]                                      low
    Create Object                               {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                        robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    # Invalid Key
    Create Object Instance With Invalid JSON    robot_custom_object   {name:"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    # Invalid value
    Create Object Instance With Invalid JSON    robot_custom_object   {"name":CUSTOM INSTANCE TEST,"test_id":{"value":"TEST"}}
    # Null
    Create Object Instance With Invalid JSON    robot_custom_object   {"name": null ,"test_id":{"value":"TEST"}}
    [Teardown]                              Delete Object    robot_custom_object

Verify It Is Possible To Create Instance With "null" String as Name
    [Tags]                                  low
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                    robot_custom_object   {"properties":{"name":{"oneOf":[{"type":"string"},{"type":"null"}]},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                  robot_custom_object   {"name": null ,"test_id":{"value":"TEST-null"}}
    ${body} =                               Get Response Body
    ${object}=     Evaluate                 json.loads('''${body}''')    json
    Delete Instance By Extenal ID           robot_custom_object    test_id    TEST-null
    [Teardown]                              Delete Object    robot_custom_object

Try to create An Instance With Reference To An Unexisting Instance
    [Tags]                                          high
    Create Object                                   {"object_type": "robot_coreunexistent_object", "name": "Robot unexistent Object", "core": true}
    Update Object Schema                            robot_coreunexistent_object   {"properties":{"cost":{"$ref":"#/currency"},"description":{"$ref":"#/rich_text"},"favicon":{"$ref":"#/url_icon"},"geometry":{"$ref":"#/geometry"},"last_maintenance":{"$ref":"#/date"},"name":{"type":"string"},"profile_picture":{"$ref":"#/url_picture"},"test_id":{"$ref":"#/external_id"},"website":{"$ref":"#/url"},"robot_object":{"$ref":"#/ref"}},"type":"object"}
    Create Object Instance Unexistent Reference     robot_coreunexistent_object   {"cost":{"value":300,"currency":"EUR"},"description":{"value":"<h1>MOBILITY</h1> <p>Example</p>"},"favicon":{"name":"Favicon","value":"http://wwww.example.com"},"geometry":{"type":"Point","coordinates":[41.4050329,2.1888402]},"last_maintenance":{"value":"2016-05-31T13:05:57Z"},"name":"CORE INSTANCE TEST-Unexistent","profile_picture":{"name":"Avatar","value":"http://wwww.example.com"},"test_id":{"value":"TEST-No-reference"},"website":{"name":"URL Example","value":"http://wwww.example.com"},"robot_object":{"internalid":200}}
    ${body} =                                       Get Response Body
    ${object} =   Evaluate                          json.loads('''${body}''')    json
    Delete Object Instance by Internal ID           ${object["id"]}

Try to Create an Instance with Additional Unexpected properties
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance With Invalid JSON        robot_custom_object   {"cost":{"value":300,"currency":"EUR"},"description":{"value":"<h1>MOBILITY</h1> <p>Example</p>"},"favicon":{"name":"Favicon","value":"http://wwww.example.com"},"geometry":{"type":"Point","coordinates":[41.4050329,2.1888402]},"last_maintenance":{"value":"2016-05-31T13:05:57Z"},"name":"CORE INSTANCE TEST","profile_picture":{"name":"Avatar","value":"http://wwww.example.com"},"test_id":{"value":"TEST-Robot"},"website":{"name":"URL Example","value":"http://wwww.example.com"},"robot_object":{"internalid":200}}
    [Teardown]                                      Delete Object    robot_custom_object

Try To Get An Instance With an Unexisting Core ID
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Get Object Instances by Unexistent Core ID      mb_traffic   simo   190239BW
    [Teardown]                                      Delete Object    robot_custom_object

Create Instances
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Core Object", "core": true}
    Update Object Schema                    robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Update Object Schema                    robot_core_object    {"properties":{"cost":{"$ref":"#/currency"},"description":{"$ref":"#/rich_text"},"favicon":{"$ref":"#/url_icon"},"geometry":{"$ref":"#/geometry"},"last_maintenance":{"$ref":"#/date"},"name":{"type":"string"},"profile_picture":{"$ref":"#/url_picture"},"test_id":{"$ref":"#/external_id"},"website":{"$ref":"#/url"},"robot_object":{"$ref":"#/ref"}},"type":"object"}
    Create Object Instance                  robot_custom_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    ${body} =                               Get Response Body
    ${object}=     Evaluate                 json.loads('''${body}''')    json
    Delete Object Instance by Internal ID   ${object["id"]}
    Create Object Instance                  robot_core_object   {"cost":{"value":300,"currency":"EUR"},"description":{"value":"<h1>MOBILITY</h1> <p>Example</p>"},"favicon":{"name":"Favicon","value":"http://wwww.example.com"},"geometry":{"type":"Point","coordinates":[41.4050329,2.1888402]},"last_maintenance":{"value":"2016-05-31T13:05:57Z"},"name":"CORE INSTANCE TEST","profile_picture":{"name":"Avatar","value":"http://wwww.example.com"},"test_id":{"value":"TEST-Robot"},"website":{"name":"URL Example","value":"http://wwww.example.com"},"robot_object":{"internalid":${custom_instance}}}
    ${body} =                               Get Response Body
    ${object}=     Evaluate                 json.loads('''${body}''')    json
    Delete Object Instance by Internal ID   ${object["id"]}
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Get Instances by Internal ID
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                    robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                  robot_custom_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    ${body} =                               Get Response Body
    ${object}=     Evaluate                 json.loads('''${body}''')    json
    Get Object Instance by Internal ID      ${object["id"]}
    Delete Object Instance by Internal ID   ${object["id"]}
    [Teardown]                              Delete Object    robot_custom_object

Get Instances by External ID
    [Tags]                                          critical
    Create Object                                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_custom_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    ${body} =                                       Get Response Body
    ${object}=     Evaluate                         json.loads('''${body}''')    json
    Get Object Instance by External ID              robot_custom_object  test_id  TEST
    Delete Object Instance by Internal ID           ${object["id"]}
    [Teardown]                                      Delete Object    robot_custom_object

Get Instances by Core ID
    [Tags]                                  critical
    Get Object Instances by Core ID         mb_tracking  simo  20

Update Instances by Internal ID
    [Tags]                                          high
    Create Object                                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_custom_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    ${body} =                                       Get Response Body
    ${object}=     Evaluate                         json.loads('''${body}''')    json
    Update Object Instance by Internal ID           ${object["id"]}  {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST-updated"}}
    Delete Object Instance by Internal ID           ${object["id"]}
    [Teardown]                                      Delete Object    robot_custom_object

Update Instances by External ID
    [Tags]                                          high
    Create Object                                   {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_custom_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_custom_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}
    ${body} =                                       Get Response Body
    ${object}=     Evaluate                         json.loads('''${body}''')    json
    Update Object Instance by External ID           robot_custom_object  test_id  TEST  {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST-updated"}}
    ${body} =                                       Get Response Body
    Delete Object Instance by Internal ID           ${object["id"]}
    [Teardown]                                      Delete Object    robot_custom_object

Update Instances by Core ID
    [Tags]                                          high
    Update Object Schema                            mb_tracking   {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Update Object Instance by Core ID               mb_tracking  simo  2  {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"TEST"}}

Try to Create Instance (Invalid Object Type)
    [Tags]                                          low
    Create Object Instance For Unexistent Object    robot_custom_object_unexisting   {"last_maintenance": {"value": "2016-10-26T13:05:57Z"}, "test_id": {"value": "test_id_hotspot"}, "geometry_is": {"type": "Point", "coordinates": [41.3962442, 2.1578827]}}

Try to Get Unexisting Instances
    [Tags]                                          low
    Next Request Should Not Succeed
    Get Object Instance by Unexistent Internal ID   5000

Try to Delete Unexisting Instances
    [Tags]                                              low
    Delete Object Instance by Unexistent Internal ID    5000

Try to Create An Instance with External ID Longer Than Max Permitted Lenght
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_longinstance_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_longinstance_object  {"properties":{"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance With Invalid JSON        robot_longinstance_object   {"name":"CUSTOM INSTANCE TEST","test_id":{"value":"test_maximum_lenght_for_external_id"}}

Try to Delete Others With An Invalid JSON
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_others_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_others_object   {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_others_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-OTHERS-1"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                          robot_others_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-OTHERS-2"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    # Invalid Key
    Delete Other Instances With Invalid JSON        robot_custom_object   {external_id: "test_id", "survivors": ["TEST-OTHERS-1"]}
    # Invalid Value
    Delete Other Instances With Invalid JSON        robot_custom_object   {"external_id": test_id, "survivors": ["TEST-OTHERS-1"]}
    # Non List
    Delete Other Instances With Invalid JSON        robot_custom_object   {"external_id": test_id, "survivors": "["TEST-OTHERS-1"]"}
    [Teardown]    Run Keywords                      Delete Instance By Extenal ID    robot_others_object    test_id    TEST-OTHERS-1
    ...           AND                               Delete Instance By Extenal ID    robot_others_object    test_id    TEST-OTHERS-2
    ...           AND                               Delete Object    robot_others_object

Try To Delete Others (Unexisting Object Type)
    [Tags]                                  high
    Delete Other Unexistent Instances       robot_custom_object_unexisting     {"external_id": "test_id", "survivors": ["TEST"]}

Delete Others
    [Tags]                                              high
    Create Object                                       {"object_type": "robot_others_object", "name": "Robot Custom Object", "core": false}
    Update Object Schema                                robot_others_object   {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                              robot_others_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-OTHERS-1"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                              robot_others_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-OTHERS-2"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                              robot_others_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-OTHERS-3"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Delete Other Instances                              robot_others_object     {"external_id": "test_id", "survivors": ["TEST-OTHERS-3"]}
    Assert Response                                     200 OK    {"deleted_elements": 2}
    Get Object Instance by Unexistent External ID       robot_others_object    test_id    TEST-OTHERS-1
    Assert Response                                     404    {"message": "There is no instance with id {\\"test_id\\": \\"TEST-OTHERS-1\\"}"}
    Get Object Instance by Unexistent External ID       robot_others_object    test_id    TEST-OTHERS-2
    Assert Response                                     404    {"message": "There is no instance with id {\\"test_id\\": \\"TEST-OTHERS-2\\"}"}
    Get Object Instance by External ID                  robot_others_object    test_id    TEST-OTHERS-3
    Assert Response                                     200 OK    "test_id": {"type": "external_id", "value": "TEST-OTHERS-3"}
    [Teardown]    Run Keywords                          Delete Instance By Extenal ID    robot_others_object    test_id    TEST-OTHERS-3
    ...           AND                                   Delete Object    robot_others_object

Delete Other (CORE Object)
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Core Object", "core": true}
    Next Request Should Not Succeed
    Delete Other Instances                  robot_core_object     {"external_id": "test_id", "survivors": ["TEST-Robot"]}
    Assert Response                         400 BAD REQUEST    {"message": "Action not permitted for core objects"}
    [Teardown]                              Delete Object    robot_core_object

Try To Create Invalid Number Instances
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_number_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_number_test     {"properties":{"Number":{"type":"number"}, "test_id":{"$ref":"#/external_id"}},"type": "object"}
    Create Object Instance With Invalid JSON        robot_number_test     {"Number": 0,3, "test_id": {"value": "negative"}}
    Create Object Instance With Invalid JSON        robot_number_test     {"Number": "3", "test_id": {"value": "negative"}}
    [Teardown]                                      Delete Object    robot_number_test

Create Valid Number Instances
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_valid_number_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_valid_number_test     {"properties":{"Number":{"type":"number"}, "test_id":{"$ref":"#/external_id"}},"type": "object"}
    Create Object Instance                          robot_valid_number_test     {"Number": -1, "test_id": {"value": "negative"}}
    ${negative} =       Get Instance Internal ID    robot_valid_number_test      test_id     negative
    Delete Object Instance by Internal ID           ${negative}
    Create Object Instance                          robot_valid_number_test     {"Number": 0, "test_id": {"value": "zero"}}
    ${zero} =       Get Instance Internal ID        robot_valid_number_test      test_id     zero
    Delete Object Instance by Internal ID           ${zero}
    Create Object Instance                          robot_valid_number_test     {"Number": 1.0, "test_id": {"value": "float"} }
    ${float} =       Get Instance Internal ID       robot_valid_number_test      test_id     float
    Delete Object Instance by Internal ID           ${float}
    Create Object Instance                          robot_valid_number_test     {"Number": 1123456789123456789123456789123456789123456789123456789, "test_id": {"value": "long"} }
    ${long} =       Get Instance Internal ID        robot_valid_number_test      test_id     long
    Delete Object Instance by Internal ID           ${long}
    [Teardown]                                      Delete Object    robot_valid_number_test

Try To Create Invalid Integer Instances
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_integer_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_integer_test     {"properties":{"Number":{"type":"integer"}, "test_id":{"$ref":"#/external_id"}},"type": "object"}
    Create Object Instance With Invalid JSON        robot_integer_test     {"Number": 0.3, "test_id": {"value": "float"}}
    Create Object Instance With Invalid JSON        robot_integer_test     {"Number": "0.3", "test_id": {"value": "string"}}
    [Teardown]                                      Delete Object    robot_integer_test

Create Valid Integer Instances
    [Tags]                                          high
    Create Object                                   {"object_type": "robot_valid_integer_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_valid_integer_test     {"properties":{"Number":{"type":"integer"}, "test_id":{"$ref":"#/external_id"}},"type": "object"}
    Create Object Instance                          robot_valid_integer_test     {"Number": -1, "test_id": {"value": "negative"}}
    Response Status Code Should Equal               201 CREATED
    ${negative} =       Get Instance Internal ID    robot_valid_integer_test      test_id     negative
    Delete Object Instance by Internal ID           ${negative}
    Create Object Instance                          robot_valid_integer_test     {"Number": 0, "test_id": {"value": "zero"}}
    Response Status Code Should Equal               201 CREATED
    ${zero} =       Get Instance Internal ID        robot_valid_integer_test      test_id     zero
    Delete Object Instance by Internal ID           ${zero}
    Create Object Instance                          robot_valid_integer_test     {"Number": 1123456789123456789123456789123456789123456789123456789, "test_id": {"value": "long"} }
    Response Status Code Should Equal               201 CREATED
    ${long} =       Get Instance Internal ID        robot_valid_integer_test      test_id     long
    Delete Object Instance by Internal ID           ${long}
    [Teardown]                                      Delete Object    robot_valid_integer_test


Try To Create An Instance With An Invalid Date Format
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_date_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_date_test     {"properties":{"last_maintenance":{"$ref":"#/date"}},"type": "object"}
    Create Object Instance With Invalid JSON        robot_date_test     {"last_maintenance":{"value":"11-05T13:15:30Z"}}
    [Teardown]                                      Delete Object    robot_date_test

Try To Create An Instance With An Invalid Currency
    [Tags]                                          low
    Create Object                                   {"object_type": "robot_currency_test", "name": "Robot Custom Object", "core": false}
    Update Object Schema                            robot_currency_test     {"properties":{"cost":{"$ref":"#/currency"}},"type": "object"}
    # Currency not in Enumerate
    Create Object Instance With Invalid JSON        robot_currency_test     {"cost":{"value":300,"currency":"BSF"}}
    Response Body Should Contain                    {"message": "{u'currency': u'BSF', 'type': u'currency', u'value': 300} is not valid under any of the given schemas"}
    # Null Value
    Create Object Instance With Invalid JSON        robot_currency_test     {"cost":{"value":null,"currency":"EUR"}}
    Response Body Should Contain                    {"message": "{u'currency': u'EUR', 'type': u'currency', u'value': None} is not valid under any of the given schemas"}
    # String Value
    Create Object Instance With Invalid JSON        robot_currency_test     {"cost":{"value": "300","currency":"EUR"}}
    Response Body Should Contain                    {"message": "{u'currency': u'EUR', 'type': u'currency', u'value': u'300'} is not valid under any of the given schemas"}
    [Teardown]                                      Delete Object    robot_currency_test

# Visualizations
Create Map Visualizations
    [Tags]                                  low
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Custom Object", "core": true}
    Update Object Visualization Map         robot_custom_object   ${visualization_map_hotspot}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       200 OK
    Update Object Visualization Map         robot_core_object   ${visualization_map_rubish_container}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       200 OK
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Create Popup Visualizations
    [Tags]                                  low
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Custom Object", "core": true}
    Update Object Visualization Popup       robot_custom_object   ${visualization_popup_hotspot}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       200 OK
    Update Object Visualization Popup       robot_core_object   ${visualization_popup_rubish_container}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       200 OK
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Try to Create Invalid Map Visualization
    [Tags]                                  low
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Update Object Visualization Map         robot_custom_object   ${visualization_map_invalid}
    Assert Response                         404    {"message": "Invalid JSON"}
    [Teardown]                              Delete Object    robot_custom_object

Try to Create Map Visualization (Invalid Object Type)
    [Tags]                                  low
    Next Request Should Not Succeed
    Update Object Visualization Map         robot_custom_object_unexisting   ${visualization_map_hotspot}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "Object robot_custom_object_unexisting doesn't exist."}

Try to Create Invalid Popup Visualization
    [Tags]                                  low
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Next Request Should Not Succeed
    Update Object Visualization Popup       robot_custom_test   ${visualization_popup_invalid}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       400 BAD REQUEST
    Response Body Should Contain            {"message": "Invalid JSON"}
    [Teardown]                              Delete Object    robot_custom_object

Try to Create Popup Visualization (Invalid Object Type)
    [Tags]                                  low
    Next Request Should Not Succeed
    Update Object Visualization Popup       robot_custom_object_unexisting   ${visualization_popup_hotspot}
    ${body} =                               Get Response Body
    Response Status Code Should Equal       404
    Response Body Should Contain            {"message": "Object robot_custom_object_unexisting doesn't exist."}

Get Visualizations
    [Tags]                                  critical
    Create Object                           {"object_type": "robot_custom_object", "name": "Robot Custom Object", "core": false}
    Create Object                           {"object_type": "robot_core_object", "name": "Robot Custom Object", "core": true}
    Get Object Visualizations               robot_custom_object
    Get Object Visualizations               robot_core_object
    [Teardown]    Run Keywords              Delete Object     robot_custom_object
    ...           AND                       Delete Object     robot_core_object

Try to Get Unexisting Visualization
    [Tags]                                  low
    Next Request Should Not Succeed
    Get Unexistent Object Visualizations    robot_custom_object_unexisting
    Response Body Should Contain            {"message": "Object robot_custom_object_unexisting doesn't exist."}


Get a Stub of an Object with Lists
    [Tags]                                  high
    Create Object                           {"object_type": "robot_list", "name": "Robot Object with List", "core": false}
    Update Object Schema                    robot_list   {"type": "object", "properties": {"name": {"type": "string"}, "robot_custom_object": {"type": "array", "items": {"$ref": "#/ref"}}, "hotspots": {"$ref": "#/ref"}, "description": {"$ref": "#/rich_text"}, "last_maintenance": {"$ref": "#/date"}, "test_id": {"$ref": "#/external_id"}, "profile_picture": {"$ref": "#/url_picture"}, "geometry": {"$ref": "#/geometry"}}}
    Get Object Stub                         robot_list
    [Teardown]                              Delete Object    robot_list

Try To Delete Unexisting Object
    [Tags]                                  low
    Next Request Should Not Succeed
    Delete Object                           no_schema
    Response Body Should Contain            {"message": "Object no_schema doesn't exist."}

# Influence Zones
Verify COS Registers/Deletes Instance Position On IZ Service
    [Tags]                                          integration
    Create Object                                   {"object_type": "robot_iz_object", "name": "Robot Object Influence Zone", "core": false}
    Update Object Schema                            robot_iz_object   {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_iz_object   {"name":"CUSTOM INSTANCE INFLUENCER TEST","test_id":{"value":"TEST-IZ"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    ${id} =                                         Get Instance Internal ID    robot_iz_object    test_id    TEST-IZ
    Get Instances On Influence Zone Service         {"radius": 200,"geometry": {"type": "Point","coordinates": [-66.88138872385025, 10.470800190648891]}}
    Verify Position                                 {u'type': u'Point', u'coordinates': [-66.8813323974609, 10.469581642954]}
    Verify ID                                       ${id}
    Delete Instance By Extenal ID                   robot_iz_object    test_id    TEST-IZ
    Get Instances On Influence Zone Service         {"radius": 200,"geometry": {"type": "Point","coordinates": [-66.88138872385025, 10.470800190648891]}}
    Verify Response Is Empty
    [Teardown]                                      Delete Object    robot_iz_object

Verify COS Delete Others On IZ Service
    [Tags]                                          integration
    Create Object                                   {"object_type": "robot_iz_object", "name": "Robot Object Influence Zone", "core": false}
    Update Object Schema                            robot_iz_object    {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}},"type":"object"}
    Create Object Instance                          robot_iz_object    {"name":"CUSTOM INSTANCE INFLUENCER TEST 0","test_id":{"value":"TEST-OTHERS-0"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                          robot_iz_object    {"name":"CUSTOM INSTANCE INFLUENCER TEST 1","test_id":{"value":"TEST-OTHERS-1"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                          robot_iz_object    {"name":"CUSTOM INSTANCE INFLUENCER TEST 2","test_id":{"value":"TEST-OTHERS-2"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                          robot_iz_object    {"name":"CUSTOM INSTANCE INFLUENCER TEST 3","test_id":{"value":"TEST-OTHERS-3"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Get Instances On Influence Zone Service         {"radius": 200,"geometry": {"type": "Point","coordinates": [-66.88138872385025, 10.470800190648891]}}
    Verify All Expected Instances
    Delete Other Instances                          robot_iz_object    {"external_id": "test_id", "survivors": ["TEST-OTHERS-3"]}
    Get Instances On Influence Zone Service         {"radius": 200,"geometry": {"type": "Point","coordinates": [-66.88138872385025, 10.470800190648891]}}
    Verify Only The Survivor Is Received
    Delete Instance By Extenal ID                   robot_iz_object    test_id    TEST-OTHERS-3
    [Teardown]                                      Delete Object    robot_iz_object

Verify COS Inserts Shape ID Per Instance on IZ Service
    [Tags]                                          integration
    Create Object                                   {"object_type": "robot_iz_object", "name": "Robot Object Influence Zone", "core": false}
    Update Object Schema                            robot_iz_object    {"properties":{"geometry":{"$ref":"#/geometry"},"name":{"type":"string"},"test_id":{"$ref":"#/external_id"}, "shape_id":{"type":"string"}},"type":"object"}
    Set Influence Zone Shape Definition             robot_object_triangle    {"geometry": {"type": "Polygon", "coordinates": [[[0, 1], [-1, -1], [1, -1], [0, 1]]]} ,"role":"influencer","tags": {}}
    Set Influence Zone Shape Definition             robot_object_square    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, 1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Create Object Instance                          robot_iz_object    {"shape_id":"robot_object_triangle", "name":"CUSTOM INSTANCE INFLUENCER TEST 1","test_id":{"value":"TEST-SHAPE-1"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Create Object Instance                          robot_iz_object    {"shape_id":"robot_object_square", "name":"CUSTOM INSTANCE INFLUENCER TEST 2","test_id":{"value":"TEST-SHAPE-2"},"geometry":{"type":"Point","coordinates": [-66.88133239746094, 10.469581642954008]}}
    Get Instances On Influence Zone Service         {"radius": 200,"geometry": {"type": "Point","coordinates": [-66.88138872385025, 10.470800190648891]}}
    Verify Instances Influence Zone
    Delete Instance By Extenal ID                   robot_iz_object    test_id    TEST-SHAPE-1
    Delete Instance By Extenal ID                   robot_iz_object    test_id    TEST-SHAPE-2
    Delete Influence Zone Shape Definition          robot_object_triangle
    Delete Influence Zone Shape Definition          robot_object_square
    [Teardown]                                      Delete Object    robot_iz_object
