*** Settings ***
Documentation       Script para realizar la configuración inicial del EMP.
Resource            ../../keywords/emp/keywords_login.robot
#Suite Setup         Setup Incidents
#Suite Teardown      Teardown Incidents

*** Test Cases ***
# Avoid Auth Problem
#     Open Browser To Login Page    ${PROBLEM_URL}

# Initial Setup
#     Open Browser To Login Page
#     Log In      admin   5737b3f
#     Start Initial Setup
#     Change Admin Password
#     Create New User
#     Change DB System Password
#     Jurisdiction Set Up
#     Finish Initial Setup
#
# Review Initial Setup
#     Open Browser To Login Page
#     Log In      saes   Saes1234!
#     Start Setup Review
#     Change SAES Password
#     Finish Review

Bulk Data Load
    Open Browser To Login Page
    Log In      saes   Abcd1234!
    Enter System Administrator Tasks
    Enter Import Data Module
    Upload File     1-ELECTORAL_SUBDIVISION.csv
    Upload File     2-DISTRICT.csv
    Upload File     3-POLLING_PLACE.csv
    Upload File     4-USER.csv

# Complete Tasks
#     Open Browser To Login Page
#     Log In      saes   Abcd1234!
#     Complete Divisiones Electorales Tasks
#     Complete Distritos Tasks


*** Keywords ***
Log In
    [Arguments]                             ${username}    ${password}
    Input Text                              usernameInput    ${username}
    Input Password                          passwordInput    ${password}
    Click Button                            login-submit-button
    Wait Until Element is Visible           xpath=${info}  timeout=10s

Start Initial Setup
    Wait Until Element is Visible           startBtn
    Click Button                            startBtn
    Wait Until Element is Visible           new-password    timeout=10s

Change Admin Password
    Input Text                              new-password    Abcd1234!
    Input Text                              confirm-password    Abcd1234!
    Wait Until Element Is Enabled           nextBtn
    Click Button                            nextBtn
    Wait Until Element is Visible           name    timeout=10s

Create New User
    Input Text                              name    Super
    Input Text                              lastname    Administrador
    Input Text                              username    saes
    Input Text                              new-password    Saes1234!
    Input Text                              confirm-password    Saes1234!
    Wait Until Element Is Enabled           nextBtn
    Click Button                            nextBtn
    Wait Until Element is Visible           new-password    timeout=10s

Change DB System Password
    Input Text                              new-password    Saes1234
    Input Text                              confirm-password    Saes1234
    Wait Until Element Is Enabled           nextBtn
    Click Button                            nextBtn
    Wait Until Element is Visible           jurisdictionName    timeout=10s

Jurisdiction Set Up
    Input Text                              jurisdictionName    Argentina
    Select From List By Value               initial-setup-select    Catamarca
    Input Text                              jurisdictionCity    CABA
    Wait Until Element is Visible           xpath:${polling_place_check}    timeout=10s
    Click Element                           xpath:${polling_place_check}
    Wait Until Element Is Enabled           nextBtn
    Click Button                            nextBtn
    Wait Until Element is Visible           nextBtn    timeout=10s
    Element Text Should Be                  xpath:${finish_btn}    Terminar

Finish Initial Setup
    Click Button                            nextBtn

Start Setup Review
    Wait Until Element is Visible           startBtn
    Click Button                            startBtn
    Wait Until Element is Visible           new-password    timeout=10s

Change SAES Password
    Input Text                              new-password    Abcd1234!
    Input Text                              confirm-password    Abcd1234!
    Wait Until Element Is Enabled           nextBtn
    Click Button                            nextBtn
    Wait Until Element is Visible           nextBtn    timeout=10s
    Element Text Should Be                  ${finish_btn}    Terminar

Finish Review
    Click Button                            nextBtn
    Wait Until Element is Visible           finishBtn
    Click Button                            finishBtn

# Import Data
Enter System Administrator Tasks
    Click Element                           ${menu}
    Click Element                           ${menu_drop_sysadmin}
    Wait Until Page Contains                Administración del Sistema
    Wait Until Element is Visible           id:task:data-import

Enter Import Data Module
    Click Element                           id:task:data-import
    Wait Until Page Contains                Importar Data

Upload File
    [Arguments]                             ${file}
    Wait Until Element Is Enabled           inputSelectFiles
    Choose File                             inputSelectFiles    ${ROBOT_DIR}/resources/DATA/EMP/${file}
    Wait Until Element Is Enabled           ${validate_btn}    timeout=5m
    Click Button                            ${validate_btn}
    Wait Until Element Is Enabled           ${next_btn}    timeout=5m
    Click Button                            ${next_btn}
    Wait Until Element is Visible           ${next_btn}    timeout=5m
    Element Text Should Be                  ${next_btn}    Guardar
    Click Button                            ${next_btn}
    Wait Until Element is Visible           linkSelectFiles    timeout=5m
    Capture Page Screenshot


# Tasks
Complete Divisiones Electorales Tasks
    Click Button                            ${divele_btn}
    Wait Until Element is Visible           ${complete_divele}
    Click Element                           ${complete_divele}

Complete Distritos Tasks
    Click Button                            ${distritos_btn}
    Wait Until Element is Visible           ${complete_distritos}
    Click Element                           ${complete_distritos}
