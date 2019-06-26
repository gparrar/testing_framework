*** Settings ***
Documentation     Doc
Resource          ../keywords_commons.robot
Variables         ../../variables/emp/${ENV}_variables.py

*** Keywords ***
Ingresar
    [Arguments]                             ${VALID_USER}   ${VALID_PASSWORD}
    Selenium2Library.Input Text             username    ${VALID_USER}
    Selenium2Library.Input Password         password    ${VALID_PASSWORD}
    Click Button                            xpath:${login_btn}
    Wait Until Element is Visible           xpath:${module_header}   timeout=10s

Log Out
    Click Element                           xpath://img[@src="img/logout.png"]
    Wait Until Element is Visible           kc-content   timeout=10s

Ingresar Como Operador
    Ingresar    ${OPERADOR_USER}   ${OPERADOR_PASSWORD}

Ingresar Como Supervisor
    Ingresar    ${OPERADOR_USER}   ${OPERADOR_PASSWORD}

Ingresar Como Transcriptor
    Ingresar    ${OPERADOR_USER}   ${OPERADOR_PASSWORD}
