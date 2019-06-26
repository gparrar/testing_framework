*** Settings ***
Documentation                   Black box tests Influence Zone Service
...                             Missing Tests:
...                             - Multiple types of polygons as Definitions
Resource                        ../../keywords/service_influence_zone/keywords_influence_zone.robot
Test Setup                      Create HTTP Context     ${SERVER}  ${SCHEME}


*** Test Cases ***
Verify is not possible To Set An Influence Zone Shape Definition With Empty ID
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     ${EMPTY}    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         404    <title>404 Not Found</title>

Verify is not possible To Set An Influence Zone Shape Definition With Special Chars As ID Separator
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot*influence*zone    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Shape id must match pattern

Verify is not possible To Set An Influence Zone Shape Definition With Empty Spaces As ID Separator
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot influence zone    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Shape id must match pattern

Verify is not possible To Set An Influence Zone Shape Definition With Empty Role
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"role":"","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "u'' is not one of ['influencer', 'influenced']"}

Verify is not possible To Set An Influence Zone Shape Definition With Null Role
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"role": null,"tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "None is not one of ['influencer', 'influenced']"}

Verify is not possible To Set An Influence Zone Shape Definition Without Role
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "'role' is a required property"}

Verify is not possible To Set An Influence Zone Shape Definition With Empty Geometry
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {},"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "{} is not valid under any of the given schemas"}

Verify is not possible To Set An Influence Zone Shape Definition With Null Geometry
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": null,"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "None is not valid under any of the given schemas"}

Verify is not possible To Set An Influence Zone Shape Definition Without Geometry
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}

Verify is not possible To Set An Influence Zone Shape Definition With Invalid Geometry
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1]]},"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1]],[-1.15,-1]},"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}

Verify is not possible To Set An Influence Zone Shape Definition With Empty Tags
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"role":"influencer","tags":}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}

Verify is not possible To Set An Influence Zone Shape Definition With Null Tags
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object   {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"role":"influencer","tags":null}
    Assert Response                         400 BAD REQUEST    {"message": "None is not of type 'object'"}

Verify is not possible To Set An Influence Zone Shape Definition With Invalid Tags
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     1    {"geometry": {"type": "Polygon","coordinates":[[[1,-1],[1,1],[-1,-1],[-1,-1],[1,-1]]]},"role":"influencer","tags": []}
    Assert Response                         400 BAD REQUEST    {"message": "[] is not of type 'object'"}

Verify is not possible To Set An Influence Zone Shape Definition With Buffer Radius as String
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Buffer", "radius": "20"} ,"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "{u'radius': u'20', u'type': u'Buffer'} is not valid under any of the given schemas"}

Verify is not possible To Set An Influence Zone Shape Definition With Null Buffer Radius
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Buffer", "radius": null} ,"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "{u'radius': None, u'type': u'Buffer'} is not valid under any of the given schemas"}

Verify is not possible To Set An Influence Zone Shape Definition With Empty Buffer Radius
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Buffer", "radius": ${EMPTY}} ,"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}

Verify is not possible To Set An Influence Zone Shape Definition Without Buffer Radius
    [tags]                                  Shape Definition    medium
    Next Request Should Not Succeed
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Buffer"} ,"role":"influencer","tags": {}}
    Assert Response                         400 BAD REQUEST    {"message": "{u'type': u'Buffer'} is not valid under any of the given schemas"}

Set An Delete Influence Zone Shape Definition
    [tags]                                  Shape Definition
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         201 CREATED    {"message": "Influence zone definition inserted"}
    Get Influence Zone Shape Definition     robot_object
    Assert Response                         200 OK    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Delete Influence Zone Shape Definition  robot_object
    Assert Response                         200 OK    {"message": "Influence zone definition deleted"}
    Next Request Should Not Succeed
    Get Influence Zone Shape Definition     robot_object
    Assert Response                         404    {"message": "Influence zone definition not found"}

Set An Influence Zone Shape Definition With Null Id
    [tags]                                  Shape Definition
    Set Influence Zone Shape Definition     null    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         201 CREATED    {"message": "Influence zone definition inserted"}
    Delete Influence Zone Shape Definition  null

Set An Influence Zone Shape Definition Without Tags
    [tags]                                  Shape Definition
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer"}
    Assert Response                         201 CREATED    {"message": "Influence zone definition inserted"}
    Get Influence Zone Shape Definition     robot_object
    Assert Response                         200 OK    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Delete Influence Zone Shape Definition  robot_object

Set An Influence Zone Shape Definition With Empty List of Tags
    [tags]                                  Shape Definition
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Assert Response                         201 CREATED    {"message": "Influence zone definition inserted"}
    Delete Influence Zone Shape Definition  robot_object

Set An Influence Zone Shape Definition With Buffer Geometry
    Set Influence Zone Shape Definition     robot_object    {"geometry": {"type": "Buffer", "radius": 20} ,"role":"influencer","tags": {}}
    Assert Response                         201 CREATED    {"message": "Influence zone definition inserted"}
    Delete Influence Zone Shape Definition  robot_object

Get A List Of Influence Zone Shape Definitions
    [tags]                                  Get Definitions
    Set Influence Zone Shape Definition     robot_object      {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Set Influence Zone Shape Definition     robot_object_1    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    Set Influence Zone Shape Definition     robot_object_2    {"geometry": {"type": "Polygon", "coordinates": [[[1, -1], [1, 1], [-1, -1], [-1, -1], [1, -1]]]}, "role": "influencer", "tags": {}}
    List Influence Zones Shapes
    Assert Response                         200 OK    {"
    Delete Influence Zone Shape Definition  robot_object
    Delete Influence Zone Shape Definition  robot_object_2
    Delete Influence Zone Shape Definition  robot_object_1

Verify It Is Not Possible To Get Influence With Null Radius
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": null ,"geometry": {"type": "Point","coordinates": [2.175614833831787, 41.39488790175741]}}
    Assert Response                         400 BAD REQUEST    {"message": "None is not of type 'integer'"}

Verify It Is Not Possible To Get Influence With Radius as String
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": "200" ,"geometry": {"type": "Point","coordinates": [2.175614833831787, 41.39488790175741]}}
    Assert Response                         400 BAD REQUEST    {"message": "u'200' is not of type 'integer'"}

Verify It Is Not Possible To Get Influence With Empty Radius
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": ${EMPTY} ,"geometry": {"type": "Point","coordinates": [2.175614833831787, 41.39488790175741]}}
    Assert Response                         400 BAD REQUEST    {"message": "Invalid JSON"}

Verify It Is Not Possible To Get Influence With Empty Geometry
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": 200, "geometry": {}}
    Assert Response                         400 BAD REQUEST    {"message": "'type' is a required property"}

Verify It Is Not Possible To Get Influence With Null Geometry
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": 200, "geometry": null}
    Assert Response                         400 BAD REQUEST    {"message": "None is not of type 'object'"}

Verify It Is Not Possible To Get Influence Without Geometry
    [tags]                                  Get Influence    medium
    Next Request Should Not Succeed
    Get Influence                           {"radius": 200}
    Assert Response                         400 BAD REQUEST    {"message": "'geometry' is a required property"}

Get Influence (No Elements)
    [tags]                                  Get Influence
    Get Influence                           {"radius": 1 ,"geometry": {"type": "Point","coordinates": [-66.898590, 10.498141]}}
    Assert Response                         200 OK    {"instances": []}

Get Influence (1 Element)
    [tags]                                  Get Influence
    [Setup]                                 Create Environment
    Get Influence                           {"radius": 120 ,"geometry": {"type": "Point","coordinates": [-66.898590, 10.498141]}}
    Assert Response                         200 OK    {"instances": [{
    [Teardown]                              Delete Environment

Get Influence (Touching Influence Radius)
    [tags]                                  Get Influence
    [Setup]                                 Create Environment
    Get Influence                           {"radius": 500 ,"geometry": {"type": "Point","coordinates": [-66.898590, 10.498141]}}
    Assert Response                         200 OK    {"instances": [{
    [Teardown]                              Delete Environment

Get Object Type Shapes
    [tags]                                  Get Types
    [Setup]                                 Create Environment
    Get object Types With Shape
    Assert Response                         200 OK    {"object_types": ["robot_iz_test", "mb_tracking"]}
    [Teardown]                              Delete Environment
