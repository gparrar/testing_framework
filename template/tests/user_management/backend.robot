*** Settings ***
Documentation       TRAVELTIMES PACKAGE GUI TESTING
Resource            ../../keywords/user_management/keywords_user_management.robot
Library           ../../libraries/service_actions/ActionController.py    ${SERVER}    6000

*** Test Cases ***
Verify Access To Custom Objects API
    Authentication
    Test Custom Object Endpoint

Verify Access To SQL API
    Authentication
    Test SQL API

Verify Access To Maps API
    Authentication
    Test Maps API

Verify Access To Influence Zones API
    Authentication
    Test Influences Endpoint

Verify Access To Actions API
    Authentication
    Test Actions Endpoint

Verify Access To Actions Log API
    Authentication
    Test Action Endpoint

Verify Actions - Supervisor
    [tags]                                  critical
    [Setup]                                 Register Actions
    Authentication                          robot-supervisor    supervisor
    Test Action
    [Teardown]                              Delete Actions    robot-group

Verify Actions - User
    [tags]                                  critical
    [Setup]                                 Register Actions
    Authentication                          robot-user    user
    Test Actions With Invalid User
    [Teardown]                              Delete Actions    robot-group
