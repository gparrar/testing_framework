*** Settings ***
Documentation       TRACKING PACKAGE GUI TESTING
Resource            ../../keywords/object_tracking/keywords_tracking_gui.robot
Suite Setup         Setup Tracking
Suite Teardown      Teardown Tracking
Test Setup          Open Area Popup
Test Teardown       Close Popup

*** Test Cases ***

Verify It Is Possible to display an Area popup By clicking on an element
   [Tags]                                              Incidents List    Functionality    Critical
   [Setup]
    Open Area Popup

Verify It Is Possible to close popup
    [Tags]                                              Area Popup    Functionality    High  Smoke
    [Setup]
    Open Area Popup
    Close Popup
    [Teardown]

Verify Header Of Area Popup
    [Tags]                                              Area Popup    Look And Feel    Low
    [Setup]
    Open Area Popup
    Verify Header Of Area Popup

# Verify Format Of The Popup
#     [Tags]                                              Area Popup    Look And Feel    Medium

Verify Total of Elements
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Area Total Elements

verify Total of active Elements
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Area Active Elements

Verify density of Elements
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Area Density

Verify Matchin Index
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Area Matching Index
