*** Settings ***
Documentation       PRUEBAS AUTOMATIZADAS RCL
Resource            ../keywords/rcl/keywords_rcl.robot
#Suite Setup         Setup Incidents
#Suite Teardown      Teardown Incidents

*** Test Cases ***
TEST 1
  Open Browser To Login Page
  Login
