*** Settings ***
Documentation       TRAFFIC PACKAGE GUI TESTING
Resource            ../../keywords/object_traffic/keywords_traffic_gui.robot
Suite Setup         Setup Traffic
Suite Teardown      Teardown Traffic
Test Teardown       Close Popup

*** Test Cases ***

Verify it is possible to display Flow Rate / Capacity Layer by Road Segment
    [Tags]                                              Private Layers    Functionality    High
    Select Flow Rate / Capacity Layer
    Open Element Popup                                  rs

Verify it is possible to display Density / Max Density Layer by Road Segment
    [Tags]                                              Private Layers    Functionality    High
    Select Density / Max Density Layer
    Open Element Popup                                  rs

Verify it is possible to display Matching Index Layer by Road Segment
    [Tags]                                              Private Layers    Functionality    High
    Select Matching Index Layer
    Open Element Popup                                  rs

Verify it is possible to display PHF Layer by Road Segment
    [Tags]                                              Private Layers    Functionality    High
    Select PHF Layer
    Open Element Popup                                  rs

Verify it is possible to display Flow Rate / Capacity Layer by Area
    [Tags]                                              Private Layers    Functionality    High
    Select Area Layer
    Select Flow Rate / Capacity Layer
    Open Element Popup                                  area

Verify it is possible to display Density / Max Density Layer by Area
    [Tags]                                              Private Layers    Functionality    High
    Select Area Layer
    Select Density / Max Density Layer
    Open Element Popup                                  area

Verify it is possible to display Matching Index Layer by Area
    [Tags]                                              Private Layers    Functionality    High
    Select Area Layer
    Select Matching Index Layer
    Open Element Popup                                  area

Verify it is possible to display PHF Layer by Area
    [Tags]                                              Private Layers    Functionality    High
    Select Area Layer
    Select PHF Layer
    Open Element Popup                                  area

Verify Header Of Area Popup
    [Tags]                                              Area Popup    Look And Feel    Low
    Select Area Layer
    Open Area Popup
    Verify Header Of Area Popup

Verify It Is Possible To Close Area Popup
    [Tags]                                              Area Popup    Functionality    High
    Select Area Layer
    Open Area Popup

Verify Counter Of Flow (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Select Area Layer
    Open Area Popup
    Validate Area Flow

Verify Counter Of Flow MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Select Area Layer
    Open Area Popup
    Validate Area Flow MI

# Verify its posible to add another public layer to the view
# Verify it's possible to add Incidents layer to anocher plugin
# Verify Road Segment Layers tooltip
# Verify Area Layers tooltip
# Verify it is possible to display a popup by clicking on an Road Segment - Flow Rate / Capacity
# Verify Status Color of Road Segment Icon
# Verify it is possible to display a popup by clicking on an Road Segment - Density
# Verify Status Color of Road Segment Icon
# Verify it is possible to display a popup by clicking on an Road Segment - Matching Index
# Verify Status Color of Road Segment Icon
# Verify it is possible to display a popup by clicking on an Road Segment - PHF
# Verify Status Color of Road Segment Icon
# Verify it is possible to display a popup by clicking on an Area - Flow Rate / Capacity
# Verify Status Color of Area
# Verify it is possible to display a popup by clicking on an Area - Density
# Verify Status Color of Area
# Verify it is possible to display a popup by clicking on an Area - Matching Index
# Verify Status Color of Area
# Verify it is possible to display a popup by clicking on an Area - PHF
# Verify Status Color of Area
