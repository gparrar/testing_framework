*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_traveltimes/keywords_traveltimes.robot
Suite Setup         Setup Traveltimes
Suite Teardown      Teardown Traveltimes
Test Teardown       Close Popup

*** Test Cases ***

Verify It Is Possible To Display A Route Popup By Clicking On An Element
    [Tags]                                              Routes List    Functionality    Critical
    Open Route Popup

Verify Header Of Route Popup
    [Tags]                                              Route Popup    Look And Feel    Low
    Open Route Popup
    Verify Header Of Route Popup

Verify It Is Possible To Close Route Popup
    [Tags]                                              Route Popup    Functionality    High
    Open Route Popup
    Close Popup
    [Teardown]

Verify Route Counter Of Average Speed
    [Tags]                                              Route Popup    KPIs    Critical
    Open Route Popup
    Validate Route Average Speed

Verify Route Counter Of Expected Time
    [Tags]                                              Route Popup    KPIs    Critical
    Open Route Popup
    Validate Route Expected Time

Verify Route Counter Of Real Time
    [Tags]                                              Route Popup    KPIs    Critical
    Open Route Popup
    Validate Route Real Time

Verify Route Counter Level Of Service
    [Tags]                                              Route Popup    KPIs    Critical
    Open Route Popup
    Validate Route Level Of Service

Verify Route Counter Matching Index
    [Tags]                                              Route Popup    KPIs    Critical
    Open Route Popup
    Validate Route Matching Index
