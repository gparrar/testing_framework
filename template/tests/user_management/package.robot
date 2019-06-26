*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/user_management/keywords_user_management.robot

*** Test Cases ***
Log In
    [Tags]                                              High Level Overview    Configuration    Medium
    Open Browser To Login Page
    Log In
    [Teardown]    Close Browser
