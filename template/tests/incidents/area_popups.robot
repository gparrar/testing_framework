*** Settings ***
Documentation       INCIDENTS PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_incidents/keywords_incidents.robot
Suite Setup         Setup Incidents
Suite Teardown      Teardown Incidents
Test Setup          Open Area Popup
Test Teardown       Close Popup

*** Test Cases ***

Verify Header of Area Popup
    [Tags]                                              Area Popup    Look And Feel    Medium
    Verify Header Of Area Popup

# Verify format of the Popup
# Verify chart of incidences by type
# Verify chart of incidences (historic)

Verify Total Incidences In An Area
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Current Incidents By Area

Verify Current Matching Index By Area
    [Tags]                                              Area Popup    KPIs    Critical
    Verify Current Matching Index By Area

#Verify Incidences by impact chart
