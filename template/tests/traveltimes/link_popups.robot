*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_traveltimes/keywords_traveltimes.robot
Library             Selenium2Library
Suite Setup         Setup Traveltimes
Suite Teardown      Teardown Traveltimes
Test Setup          Open Link Popup
Test Teardown       Close Popup


*** Test Cases ***

Verify Header Of Link Popup
    [Tags]                                              Link Popup    Look And Feel    Low
    Verify Header Of Link Popup

Verify It Is Possible To Close Link Popup
    [Tags]                                              Link Popup    Functionality    High
    Close Popup
    [Teardown]

Verify Link Counter Of Average Speed
    [Tags]                                              Link Popup    KPIs    Critical
    Capture Page Screenshot
    Validate Link Average Speed

Verify Link Counter Of Expected Time
    [Tags]                                              Link Popup    KPIs    Critical
    Validate Link Expected Time

Verify Link Counter Of Real Time
    [Tags]                                              Link Popup    KPIs    Critical
    Validate Link Real Time

Verify Link Counter Level Of Service
    [Tags]                                              Link Popup    KPIs    Critical
    Validate Link Level Of Service

Verify Link Counter Matching Index
    [Tags]                                              Link Popup    KPIs    Critical
    Validate Link Matching Index
