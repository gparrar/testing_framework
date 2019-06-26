*** Settings ***
Documentation       TRAFFIC PACKAGE GUI TESTING
Resource            ../../keywords/object_traffic/keywords_traffic_gui.robot
Suite Setup         Setup Traffic
Suite Teardown      Teardown Traffic
Test Setup          Setup Popups
Test Teardown       Close Popup


*** Keywords ***
Setup Popups
      Center The Map
      Open Element Popup

*** Test Cases ***
Verify Header Of Element Popup
    [Tags]                                              Element Popup    Look And Feel    Low
    Verify Header Of Element Popup

Verify It Is Possible To Close Element Popup
    [Tags]                                              Element Popup    Look And Feel    Low
    Close Popup
    [Teardown]
# Verify format of the Popup

Verify Counter Of Flow - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Flow                               rs

Verify Counter Of Flow MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Flow MI                            rs

Verify Counter Of Flow Rate / Capacity - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Flow Rate / Capacity               rs

Verify Counter Of Flow Rate / Capacity MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Flow Rate / Capacity MI            rs

Verify Counter Of Peak Hour Factor - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    [Setup]                                             Center The Map
    Validate Element Peak Hour Factor                   rs

Verify Counter Of Peak Hour Factor MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    [Setup]                                             Center The Map
    Validate Element Peak Hour Factor MI                rs

Verify Counter Of Density - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    [Setup]                                             Center The Map
    Open Element Popup
    Validate Element Density                            rs
    # Reset Map To Default

Verify Counter Of Density MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Density MI                         rs
    # Reset Map

# Verify Vehicle Types Graphic - Road Segment
# Verify Vehicle Types Graphic - Just 1 type - Road Segment
# Verify Vehicle Types Graphic - 8 types - Road Segment
# Verify Vehicle Types Graphic - More than 8 types - Road Segment

Verify Counter Of Density / Max. Density - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Density / Max. Density             rs


Verify Counter Of Density / Max. Density MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Density / Max. Density MI          rs

Verify Counter Of Avg. Speed - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Avg. Speed                         rs

Verify Counter Of Avg. Speed MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Avg. Speed MI                      rs


Verify Counter Of Congestion - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    [Setup]                                             Center The Map
    Validate Element Congestion                         rs

Verify Counter Of Congestion MI - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Congestion MI                      rs

Verify Counter Of Level of Service - Road Segment (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Validate Element Level of Service                   rs


Verify Counter Of Flow - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Flow                               lane

Verify Counter Of Flow MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Flow MI                            lane

Verify Counter Of Flow Rate / Capacity - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Flow Rate / Capacity               lane


Verify Counter Of Flow Rate / Capacity MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Flow Rate / Capacity MI            lane

Verify Counter Of Peak Hour Factor - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Peak Hour Factor                   lane

Verify Counter Of Peak Hour Factor MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Peak Hour Factor MI                lane

Verify Counter Of Density - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Density                            lane

Verify Counter Of Density MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Open Element Popup
    Select Direction
    Validate Element Density MI                         lane


# Verify Vehicle Types Graphic - Direction
# Verify Vehicle Types Graphic - Just 1 type - Direction
# Verify Vehicle Types Graphic - 8 types - Direction
# Verify Vehicle Types Graphic - More than 8 types - Direction

Verify Counter Of Density / Max. Density - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Density / Max. Density             lane

Verify Counter Of Density / Max. Density MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Density / Max. Density MI          lane

Verify Counter Of Avg. Speed - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Avg. Speed                         lane

Verify Counter Of Avg. Speed MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Avg. Speed MI                      lane

Verify Counter Of Congestion - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Congestion                         lane

Verify Counter Of Congestion MI - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Congestion MI                      lane

Verify Counter Of Level of Service - Direction (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Direction
    Validate Element Level of Service                   lane

Verify Counter Of Flow - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Flow                               lane

Verify Counter Of Flow MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Flow MI                            lane

Verify Counter Of Flow Rate / Capacity - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Flow Rate / Capacity               lane

Verify Counter Of Flow Rate / Capacity MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Flow Rate / Capacity MI            lane

Verify Counter Of Peak Hour Factor - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Peak Hour Factor                   lane

Verify Counter Of Peak Hour Factor MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Peak Hour Factor MI                lane

Verify Counter Of Density - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Density                            lane


Verify Of Density MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Density MI                         lane

# Verify Vehicle Types Graphic - Lane
# Verify Vehicle Types Graphic - Just 1 type - Lane
# Verify Vehicle Types Graphic - 8 types - Lane
# Verify Vehicle Types Graphic - More than 8 types - Lane

Verify Counter Of Density / Max. Density - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Density / Max. Density             lane

Verify Counter Of Density / Max. Density MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Density / Max. Density MI          lane

Verify Counter Of Avg. Speed - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Avg. Speed                         lane

Verify Counter Of Avg. Speed MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Avg. Speed MI                      lane

Verify Counter Of Congestion - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Congestion                         lane

Verify Counter Of Congestion MI - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Congestion MI                      lane

Verify Counter Of Level of Service - Lane (Element Popup)
    [Tags]                                              Element Popup    KPIs    Critical
    Select Lane
    Validate Element Level of Service                   lane

# Verify Density Chart
# Verify Density Chart - tooltips
# Verify Density MI Chart
# Verify Density MI Chart - tooltips
# Verify Flow Rate / Capacity Chart
# Verify Flow Rate / Capacity Chart - tooltips
# Verify Flow Rate / Capacity MI Chart
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
# Verify All KPIs are displayed even when there is no Data Available
# Verify All KPIs are displayed even when there is no Data Available
# Verify All KPIs are displayed even when there is no Data Available
