*** Settings ***
Documentation       Main View Traffic Menu
Resource            ../../keywords/object_traffic/keywords_traffic_gui.robot
Resource            ../../keywords/setup_common.robot
Suite Setup         Setup Main View
Suite Teardown      Teardown Browser

*** Test Cases ***
Verify Icon And Label Of Left Menu
    [Tags]                                              High Level Overview    Configuration    Medium
    Verify Left Menu

Verify Tooltip of Menu
    [Tags]                                              High Level Overview    Configuration    low
    Validate Tooltip
