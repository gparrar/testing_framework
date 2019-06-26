*** Settings ***
Documentation     Doc
Resource          ../keywords_commons.robot
Variables         ../../variables/rcl/${ENV}_variables.py

*** Keywords ***
Open Application
  Open Browser To Login Page
