*** Settings ***
Documentation       TRACKING PACKAGE GUI TESTING
Resource            ../../keywords/object_tracking/keywords_tracking_gui.robot
Resource            ../../keywords/setup_common.robot
Suite Setup         Setup Main View
Suite Teardown      Teardown Browser

*** Test Cases ***
Verify Icon And Label Of Left Menu
    [Tags]                                              High Level Overview    Configuration    Medium
    Verify Left Menu

Verify Tooltip Of Menu
    [Tags]                                              High Level Overview    Configuration    low
    Validate Tooltip
