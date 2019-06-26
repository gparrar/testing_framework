*** Settings ***
Documentation       TRAFFIC PACKAGE GUI TESTING
Resource            ../../keywords/object_traffic/keywords_traffic_gui.robot
Suite Setup         Setup Traffic
Suite Teardown      Teardown Traffic
Test Setup          Open Area Popup
Test Teardown       Close Popup
*** Test Cases ***

Verify Counter Of Flow Rate / Capacity (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Flow Rate / Capacity

Verify Counter Of Flow Rate / Capacity MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Flow Rate / Capacity MI

Verify Counter Of Peak Hour Factor (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Peak Hour Factor

Verify Counter Of Peak Hour Factor MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Peak Hour Factor MI

Verify Counter Of Density (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Density

Verify Counter Of Density MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Density MI

# Verify Vehicle Types Graphic
# Verify Vehicle Types Graphic - Just 1 type
# Verify Vehicle Types Graphic - 8 types
# Verify Vehicle Types Graphic - More than 8 types

Verify Counter Of Density / Max. Density (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Density / Max. Density

Verify Counter Of Density / Max. Density MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Density / Max. Density MI

Verify Counter Of Avg. Speed (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Avg. Speed

Verify Counter Of Avg. Speed MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Avg. Speed MI

Verify Counter Of Congestion (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Congestion

Verify Counter Of Congestion MI (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Congestion MI

Verify Counter Of Level of Service (Area Popup)
    [Tags]                                              Area Popup    KPIs    Critical
    Validate Area Level of Service



# Verify Density Chart
# Verify Density Chart - tooltips
# Verify Density MI Chart
# Verify Density MI Chart - tooltips
# Verify Flow Rate / Capacity Chart
# Verify Flow Rate / Capacity Chart - tooltips
# Verify Flow Rate   / Capacity MI Chart
# Verify Flow Rate / Capacity MI Chart - tooltips
# Verify Flow / Counting Chart
# Verify Flow / Counting Chart - tooltips
# Verify Flow / Counting MI Chart
# Verify Flow / Counting MI Chart - tooltips
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
# Verify LOS MI Chart
# Verify LOS MI Chart - tooltips
