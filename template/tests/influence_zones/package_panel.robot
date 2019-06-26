*** Settings ***
Documentation       This test suite will test  GUI functionalities available in
...                 Mobility Real Time View Influence zone Panel
...                 Pending Tests:
Resource            ../../keywords/service_influence_zone/keywords_gui_influence_zone.robot
Suite Setup         Setup IZ
Suite Teardown      Restore Environment By Default


*** Test Cases ***
Verify It Is Possible To Expand/Collapse Panel
    [Tags]                      Smoke
    Expand Influence Zone Panel
    Collapse Influence Zone Panel

Verify It Is Possible to Get Influence Zones Within a Radius of Interest
    [Tags]                      Smoke
    Get Influence Zone

Verify Default Radius Value
    Get Influence Zone
    Verify Radius Value               200 m.

Verify It Is Possible To Narrow Radius To Min Configurable Size
    Get Influence Zone
    Drag Radius Slider                   -201
    Verify Radius Value                  100 m.
    Drag Radius Slider                   201

Verify It Is Possible To Wide Radius To Max Configurable Size
    Get Influence Zone
    Drag Radius Slider                   201
    Verify Radius Value                  800 m.
    Drag Radius Slider                   -201

Verify Correct Visualization Of Elements
    Get Influence Zone
    Verify Elements List
    # Verify Mouse Elements List Is Scrollable

Verify It Is Possible To Filter By Actions
    Get Influence Zone
    Select Filter                                       Actions
    Element Should Not Be Visible                       second-element-name
    Element Text Should Be                              first-element-name    SEMAFORO 1
    Element Text Should Be                              third-element-name    RADAR

Verify It Is Possible To Filter By Influencer
    Get Influence Zone
    Capture Page Screenshot
    Select Filter                               Influencer
    Verify Influencer Elements Are Not Displayed

Verify It Is Possible To Filter By Influenced
    Get Influence Zone
    Capture Page Screenshot
    Select Filter                               Influenced
    Verify Influenced Elements Are Not Displayed

Verify It Is Possible To Search by Name
    Get Influence Zone
    Search For Specific Element                 INSTANCE 1
    Verify Only The Second Element Is Displayed

Verify It Is Possible To Search by ID
    Get Influence Zone
    ${ID} =                                     Get Instance Internal ID    robot_iz_test_2    test_id    IZ_INSTANCE_TEST_INFLUENCED
    Search For Specific Element                 ${ID}
    Verify Only The Third Element Is Displayed

Verify It Is Possible To Filter By Object Type
    Get Influence Zone
    Select Filter                                 Police Agent
    Verify The First Element Is Not Displayed

Verify Tooltips On Filters
    Get Influence Zone
    Verify Tooltips

# Verify It Is Possible To Display Influence Zone Of Elements
# Verify Mouse Over Element Behaviour
Verify It Is Possible To Open a Popup From Panel
    Get Influence Zone
    Open Popup
    Close Popup
