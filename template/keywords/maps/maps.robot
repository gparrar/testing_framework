*** Settings ***
Documentation     Leaflet related keywords
Library           Selenium2Library

*** Keywords ***
Get Point From Coordinates
    [Arguments]   ${long}   ${lat}
    ${retval}=   Execute Javascript    map.latLngToContainerPoint([${lat}, ${long}])
    [Return]  ${retval}
    # TODO if point x y are negative is out of map
