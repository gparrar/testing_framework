*** Settings ***
Documentation                   Black box tests Tracking Object Object
...
Resource                        ../../keywords/object_tracking/keywords_tracking.robot
#Resource                        ../../keywords/service_custom_object/keywords_custom_object.robot
Resource                        ../../keywords/service_influence_zone/keywords_influence_zone.robot

*** Test Cases ***
Verify Tracking Objects Register themselves into COS
    [Tags]                                          integration
    Get Objects
    Assert Response                                 200 OK    "name": "mb_tracking"

Verify Tracking Objects Register Shape into IZ
    [Tags]                                          integration
    List Influence Zones Shapes
    ${response}                             Parse Response
    Length Should Be                        ${response}    8
    Verify Object Registered Shape          mb_tracking1
    Verify Object Registered Shape          mb_tracking2

Verify Tracking Objects Register Position into IZ
    [Tags]                                          integration
    Get Influence                                   {"radius":10000,"geometry":{"type":"Point","coordinates":[-74.0845,4.624446]}}
    Verify Element Position                         TestingCountingSite 001    {"type": "Point", "coordinates": [-74.09952163, 4.68096794]}
    Verify Element Position                         TestingCountingSite 002    {"type": "Point", "coordinates": [-74.10690307, 4.67172909]}
    Verify Element Position                         TestingCountingSite 003    {"type": "Point", "coordinates": [-74.11325454, 4.66471432]}
    Verify Element Position                         TestingCountingSite 004    {"type": "Point", "coordinates": [-74.12029266, 4.65633072]}
    Verify Element Position                         TestingCountingSite 005    {"type": "Point", "coordinates": [-74.06913757, 4.62296644]}

Verify Counting Objects Disable Others from IZ
    [Tags]                                          integration
    Disable Others                                  robot    ["001"]
    Get Influence                                   {"radius":10000,"geometry":{"type":"Point","coordinates":[-74.0845,4.624446]}}
    Verify Disabled Elements Got Not Position       TestingCountingSite 006
    Verify Disabled Elements Got Not Position       TestingCountingSite 005
    Verify Disabled Elements Got Not Position       TestingCountingSite 004
    Verify Disabled Elements Got Not Position       TestingCountingSite 003
    Verify Disabled Elements Got Not Position       TestingCountingSite 002
    Re-Enable Disabled Elements

# Verify Tracking Objects Register themselves into COS after Restart
#     Delete Object                                   mbone_tracking
#     Delete Object                                   mbthree_tracking
#     Get Objects
#     Assert Response                                 200 OK   []
#     Restart Docker                                  mb_mbobject_tracking_onetype_1
#     Restart Docker                                  mb_mbobject_tracking_mb_threetypes_1
#     Sleep    12s
#     Get Objects
#     Assert Response                                 200 OK    "name": "mbone_tracking"
#     Assert Response                                 200 OK    "name": "mbthree_tracking"

# Verify Tracking Objects Register Shape into IZ after Restart
#     Delete Influence Zone Shape Definition          mbone_tracking1
#     Delete Influence Zone Shape Definition          mbthree_tracking1
#     Delete Influence Zone Shape Definition          mbthree_tracking2
#     Delete Influence Zone Shape Definition          mbthree_tracking3
#     List Influence Zones Shapes
#     Assert Response                                 200 OK   []
#     Restart Docker                                  mb_mbobject_tracking_onetype_1
#     Restart Docker                                  mb_mbobject_tracking_mb_threetypes_1
#     Sleep    12s
#     ${response}                             Get Response Body
#     Length Should Be                        ${response}    4
#     Verify Object Registered Shape          mbone_tracking1
#     Verify Object Registered Shape          mbthree_tracking1
#     Verify Object Registered Shape          mbthree_tracking2
#     Verify Object Registered Shape          mbthree_tracking3
