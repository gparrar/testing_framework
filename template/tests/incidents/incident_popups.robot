*** Settings ***
Documentation       INCIDENTS PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_incidents/keywords_incidents.robot
Suite Setup         Setup Incidents
Suite Teardown      Teardown Incidents
Test Setup          Open Incident Popup
Test Teardown       Close Popup

*** Test Cases ***

Verify Type
    [Tags]                                              Element Popup    KPIs    Critical
    Verify Type

Verify Impact
    [Tags]                                              Element Popup    KPIs    Critical
    Verify Impact

Verify Date
    [Tags]                                              Element Popup    KPIs    Critical
    Verify Date

Verify Description
    [Tags]                                              Element Popup    KPIs    Critical
    Verify Description

# Verify Link to subsystem
