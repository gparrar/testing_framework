*** Settings ***
Documentation       Traffic View GUI testing
Resource            ../../keywords/object_traffic/keywords_traffic_gui.robot
Suite Setup         Setup Traffic
Suite Teardown      Teardown Traffic

*** Test Cases ***
Verify Title Of Layer
    [Tags]                                              High Level Overview    Configuration    Low
    Validate Title

# Verify Format of Boxes
# Verify Format of Boxes when no Congested / Vehicle Types available

Verify City Counter Of Flow Rate / Capacity
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Flow Rate / Capacity

Verify City Counter Of Flow Rate / Capacity MI
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Flow Rate / Capacity MI
# Verify Flow Rate / Capacity Status Color

Verify Counter Of Matching Index
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Matching Index

# Verify G Matching Index Status Color
# Verify Vehicle Types Graphic
# Verify Vehicle Types Graphic - Just 1 type
# Verify Vehicle Types Graphic - 8 types
# Verify Vehicle Types Graphic - More than 8 types

Verify City Counter Of Density / Max. Density
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Density / Max. Density

Verify City Counter Of Density / Max. Density MI
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Density / Max. Density MI

# Verify Density / Max. Density Status Color

Verify City Counter Of Congestion
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Congestion

Verify City Counter Of Congestion MI
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Congestion MI

# Verify Congestion Status Color

Verify City Counter Of Peak Hour Factor
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Peak Hour Factor

Verify City Counter Of Peak Hour Factor MI
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Peak Hour Factor MI
# Verify Peak Hour Factor Status Color

Verify City Counter Of Level of Service
    [Tags]                                              High Level Overview    KPIs    Critical
    Validate Level of Service

# Verify Level of Service Status Color
# Verify Flow Rate / Capacity Chart
# Verify Flow Rate / Capacity Chart - tooltips
# Verify Flow Rate / Capacity MI Chart
# Verify Flow Rate / Capacity MI Chart - tooltips
# Verify G Matching Index Chart
# Verify G Matching Index Chart - tooltips
# Verify Vehicle Types Chart
# Verify Vehicle Types Chart - tooltips
# Verify Vehicle Types MI Chart
# Verify Vehicle Types MI Chart - tooltips
# Verify Density / Max. Density Chart
# Verify Density / Max. Density Chart - tooltips
# Verify Density / Max. Density MI Chart
# Verify Density / Max. Density MI Chart - tooltips
# Verify Congested Lanes chart
# Verify Congested Lanes chart - tooltips
# Verify Congested Lanes MI chart
# Verify Congested Lanes MI chart - tooltips
# Verify Peak hour factor Chart
# Verify Peak hour factor Chart - tooltips
# Verify Peak hour factor MI Chart
# Verify Peak hour factor MI Chart - tooltips
# Verify LOS Chart
# Verify LOS Chart - tooltips
# Verify LOS Distribution
# Verify LOS Distribution - tooltips
# Verify LOS MI
# Verify LOS MI - tooltips
# Verify Areas List Table Formating

Sort Areas List table by Area Name - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    area    asc

Sort Areas List table by Area Name - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    area    desc

Sort Areas List table by Flow Rate / Capacity - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    flow    asc

Sort Areas List table by Flow Rate / Capacity - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    flow    desc

Sort Areas List table by Density / Max Density - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    density    asc

Sort Areas List table by Density / Max Density - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    density    desc

Sort Areas List table by Peak Hour Factor - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    phf    asc

Sort Areas List table by Peak Hour Factor - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    phf    desc


# Sort Areas List table by Vehicle Types - Ascending
#     [Tags]                                              Areas List    Functionality    Medium
#     Validate Sorting    area    asc


# Sort Areas List table by Vehicle Types - Descending
#     [Tags]                                              Areas List    Functionality    Medium
#     Validate Sorting    area    asc

Sort Areas List table by Matching Index - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    matching    asc

Sort Areas List table by Matching Index - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    matching    desc

Sort Areas List table by Level of Service - Ascending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    los    asc

Sort Areas List table by Level of Service - Descending
    [Tags]                                              Areas List    Functionality    Medium
    Validate Sorting    los    desc

Verify it is possible to display an Area popup by clicking on an element
   [Tags]                                              Areas List    Functionality    Critical
    Open Area Popup

Verify Icons and Labels of Private Layers
    [Tags]                                              Private Layers    Look And Feel    Medium
    Verify Private Layers Menu
