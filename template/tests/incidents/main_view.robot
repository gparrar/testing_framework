*** Settings ***
Documentation       INCIDENTS PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_incidents/keywords_incidents.robot
Library             Selenium2Library
Suite Setup         Setup Main View
Suite Teardown      Teardown Incidents

*** Test Cases ***
Verify Icon And Label Of Left Menu
    [Tags]                                              High Level Overview    Configuration    Medium
    Verify Left Menu

Verify Tooltip of Menu
    [Tags]                                              High Level Overview    Configuration    Medium
    Validate Tooltip
