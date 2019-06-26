*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_traveltimes/keywords_traveltimes.robot
Suite Setup         Setup Traveltimes
Suite Teardown      Teardown Traveltimes

*** Test Cases ***

Verify Title Of Layer
    [Tags]                                              High Level Overview    Configuration    Low
    Validate Title

Verify City Average Speed
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate City Average Speed

Verify City Level Of Service
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate City Level Of Service

Verify City Matching Index
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate City Matching Index

# TOP layers
Verify Icons and Labels of Menu
    [Tags]                                              Private Layers    Look And Feel    Medium
    Verify Private Layers Menu

Verify It Is Possible To Display Abs. Speed Layer
    [Tags]                                              Private Layers    Functionality    High
    Select Abs. Speed Layer
    Check Layer    speed

Verify It Is Possible To Display Speed Range Layer
    [Tags]                                              Private Layers    Functionality    High
    Select Speed Range Layer
    Check Layer    speed

Verify It Is Possible To Display Matching Index Layer
    [Tags]                                              Private Layers    Functionality    High
    Select Matching Index Layer
    Check Layer    mi

# SORTING LEFT MENU
Sort Routes Table by Speed - Ascending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    speed    asc

Sort Routes Table by Speed - Descending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    speed    desc

Sort Routes Table by Name - Ascending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    name    asc

Sort Routes Table by Name - Descending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    name    desc

Sort Routes Table by Time - Ascending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    time    asc

Sort Routes Table by Time - Descending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    time    desc

Sort Routes Table by Speed Range - Ascending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    speed_range    asc

Sort Routes Table by Speed Range - Descending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    speed_range    desc

Sort Routes Table by Matching Index Range - Ascending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    matching    asc

Sort Routes Table by Matching Index Range - Descending
    [Tags]                                              Routes List    Functionality    Medium
    Validate Sorting    matching    desc
