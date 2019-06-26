*** Settings ***
Documentation       TRACKING PACKAGE GUI TESTING
Resource            ../../keywords/object_tracking/keywords_tracking_gui.robot
Suite Setup         Setup Tracking
Suite Teardown      Teardown Tracking

*** Test Cases ***

Verify Title Of Layer
    [Tags]                                              High Level Overview    Configuration    Low
    Validate Title

Verify Total Number Of Elements
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Total Number of Elements

Verify Total Number Of Active Elements
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Total Number of Active Elements

Verify Matching Index
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Matching Index


# Verify Chart of active Elements By type
#     [Tags]                                              High Level Overview    Charts    High

# Verify Chart of active Elements By type - Tooltip
#     [Tags]                                              High Level Overview    Charts    Low

# Verify Chart of active Elements (historic)
#     [Tags]                                              High Level Overview    Charts    High

# Verify Chart of active Elements (historic) - Tooltip
#     [Tags]                                              High Level Overview    Charts    Low

# Filter By type
#     [Tags]                                              High Level Overview    Functionality    Critical

# Try to Filter By type when there is only one type
#     [Tags]                                              High Level Overview    Scenario    Medium

# Verify Formating of Areas List table
#     [Tags]                                              High Level Overview    Look And Feel    Medium

Sort Areas List By Area - Ascending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    area    asc

Sort Areas List By Area - Descending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    area    desc

Sort Areas List By Total - Ascending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    total    asc

Sort Areas List By Total - Descending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    total    desc

Sort Areas List By Active - Ascending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    active    asc

Sort Areas List By Active - Descending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    active    desc

Sort Areas List By Density - Ascending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    density    asc

Sort Areas List By Density - Descending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    density    desc

Sort Areas List By MI - Ascending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    matching    asc

Sort Areas List By MI - Descending
    [Tags]                                              High Level Overview    Functionality    Medium
    Validate Sorting    matching    desc



Verify Icons and Labels of Menu
    [Tags]                                              Private Layers    Look And Feel    Medium
    Verify Private Layers Menu

# Verify It Is Possible To Display The Heatmap Layer
#     [Tags]                                              Private Layers    Functionality    High

# Verify It Is Possible To Display The Position Layer
#     [Tags]                                              Private Layers    Functionality    High

# Verify It Is Possible To Display The Number Layer
#     [Tags]                                              Private Layers    Functionality    High

# Verify It Is Possible To Display The Density Layer
#     [Tags]                                              Private Layers    Functionality    High

# Verify It Is Possible To Display The Matching Index Layer
#     [Tags]                                              Private Layers    Functionality    High

# Verify It Is Possible To display last 24 hours animation
#     [Tags]                                              Private Layers    Timelapse    High

# Verify It Is Possible To display last 24 hours animation - 2x
#     [Tags]                                              Private Layers    Timelapse    High

# Verify It Is Possible To display last 24 hours animation - 4x
#     [Tags]                                              Private Layers    Timelapse    High

# Verity It Is Possible To Add Another Public Layer To The View
#     [Tags]                                              Public Layers    Functionality    High

# Verify It Is Possible To Add Incidents Layer To Another Package
#     [Tags]                                              Public Layers    Functionality    High



# Verify Chart of active Elements By type
#     [Tags]                                              Area Popup    Charts    High

# Verify Chart of active Elements By type - Tooltip
#     [Tags]                                              Area Popup    Charts    High

# Verify Chart of active Elements (historic)
#     [Tags]                                              Area Popup    Charts    High

# Verify Chart of active Elements (historic) - Tooltip
#     [Tags]                                              Area Popup    Charts    High

# Verify Chart of accumulative matching index
#     [Tags]                                              Area Popup    Charts    High

# Verify Chart of accumulative matching index - Tooltip
#     [Tags]                                              Area Popup    Charts    High

# Filter By type
#     [Tags]                                              Area Popup    Functionality    High

# Try to filter By type when there is only one type
#     [Tags]                                              Area Popup    Scenarios    Low

# Verify Header Of Element Popup
#     [Tags]                                              Element Popup    Look And Feel    High

# Verify It Is Possible To Close Element popup
#     [Tags]                                              Element Popup    Functionality    High

# Verify format of the Popup
#     [Tags]                                              Element Popup    Look And Feel    High

# Verify Type
#     [Tags]                                              Element Popup    KPIs    Critical

# Verify Speed
#     [Tags]                                              Element Popup    KPIs    Critical

# Verify Name
#     [Tags]                                              Element Popup    KPIs    Critical

# Verify Area
#     [Tags]                                              Element Popup    KPIs    Critical

# Verify Last reading
#     [Tags]                                              Element Popup    KPIs    Critical

# Verify Last 24 hours
#     [Tags]                                              Element Popup    Timelapse    High

# Veriry Incident Icons are displayed on the Map
#     [Tags]                                              Map    Charts    Critical

# Verify Incident Icons are displayed on the map at different zoom levels
#     [Tags]                                              Map    Charts    Critical

# Verify Incident Icons are displayed on the map on different available map themes
#     [Tags]                                              Map    Charts    Critical

# Verify It Is Possible to display an Element pop up By clicking on an Icon
#     [Tags]                                              Map    Charts    Critical

# Verify It Is Possible to display an Area popup By clicking on an Area - Number Layer
#     [Tags]                                              Map    Charts    Critical

# Verify It Is Possible to display an Area popup By clicking on an Area - Density Layer
#     [Tags]                                              Map    Charts    Critical

# Verify It Is Possible to display an Area popup By clicking on an Area - MI Layer
#     [Tags]                                              Map    Charts    Critical

# Verify It Is not Possible to display any popup By clicking on the Heatmap Layer
#     [Tags]                                              Map    Charts    Critical
