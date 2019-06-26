*** Settings ***
Documentation       INCIDENTS PACKAGE GUI TESTING
Resource            ../../keywords/datafeed_incidents/keywords_incidents.robot
Suite Setup         Setup Incidents
Suite Teardown      Teardown Incidents

*** Test Cases ***
Verify Title of Layer
    [Tags]                                              High Level Overview    Configuration    Low
    Validate Title

#TODO Verify Format of Boxes
#TODO Verify chart of incidents by type
#TODO Verify tooltips in chart of incidents by type
#TODO Verify chart of incidents (historic)
#TODO Verify tooltips in chart of incidents (historic)
#TODO Verify Incidences by Area Chart - Density
#TODO Sort Incidences by Area Chart - Number - Ascending
#TODO Verify Incidences by Area Chart - Number
#TODO Sort Incidences by Area Chart - Number - Descending
#TODO Sort Incidences by Area Chart - Density - Ascending
#TODO Sort Incidences by Area Chart - Density - Descending

Verify it is possible to display an Area popup by clicking on an Area
    [Tags]                                              High Level Overview    Functionality    Critical
    Open Area Popup
    Close Popup

Verify total incidences
    [Tags]                                              High Level Overview    KPIs    Critical
    Verify Current Incidents

Verify Matching Matching Index
    [Tags]                                              High Level Overview    KPIs    Critical
    Verify Current Matching Index
# Verify Incidences by impact chart

Sort Area list by name - Ascending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    name    asc

Sort Area list by name - Descending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    name    desc

Sort Area list by type - Ascending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    type    asc

Sort Area list by type - Descending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    type    desc

Sort Area list by impact - Ascending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting*    impact    asc

Sort Area list by impact - Descending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting*    impact    desc

Sort Area list by date - Ascending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    date    asc

Sort Area list by date - Descending
    [Tags]                                              Incidents List    Functionality    Medium
    Validate Sorting    date    desc

Verify Icons and Labels of Menu
    [Tags]                                              Private Layers    Look And Feel    Medium
    Verify Private Layers Menu

Verify it is possible to display an Incident popup by clicking on an element
    [Tags]                                              Incidents List    Functionality    Critical
    Open Incident Popup
    Close Popup

Verify It Is Possible To Close Area Popup
    [Tags]                                              Area Popup    Functionality    Medium
    Open Area Popup
    Close Popup

# Filter Incidences by Type
# Verify it is possible to display the Heatmap layer
# Verify it is possible to display the Incidences layer
# Verify it is possible to display the number layer
# Verify it is possible to display the density layer
# Verify it is possible to display the Matchin Index layer
# Verity its posible to add another public layer to the view
# Verify it's possible to add Incidents layer to anocher plugin
# Veriry Incident Icons are displayed on the Map
# Verify Incident Icons are displayed on the map at different zoom levels
# Verify Incident Icons are displayed on the map on different available map themes
# Verify Element Tooltip
# Verify it is possible to display an Incident pop up by clicking on an Icon
# Verify it is possible to display an Area popup by clicking on an Area - Number layer
# Verify it is possible to display an Area popup by clicking on an Area - Density layer
# Verify it is possible to display an Area popup by clicking on an Area - MI layer
# Verify it is not possible to display any popup by clicking on the Heatmap layer
