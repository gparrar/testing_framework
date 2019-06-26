*** Settings ***
Documentation     Setups and teardown common for all suites
Resource          keywords_commons.robot
Library           Selenium2Library
Variables         ../variables/global_variables.py

*** Keywords ***
Setup Main View
    Open Browser To Login Page
    Login

Teardown Browser
    Log Out
    Close Browser

Get Point From Coordinates
    [Arguments]   ${long}   ${lat}
    # DEBUG  Get Element Size    map
    # DEBUG  Execute Javascript   point = map.latLngToContainerPoint
    ${point}=   Execute Javascript    point = map.latLngToContainerPoint([${lat}, ${long}]); relx =  point.x - Math.floor(map._size.x / 2); rely =   point.y - Math.floor(map._size.y / 2); return {"x": relx, "y": rely};
    [Return]    ${point}
