*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_traveltimes/keywords_traveltimes.robot
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
