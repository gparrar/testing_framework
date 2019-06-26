*** Settings ***
 Documentation     A resource file containing Tracking Object specific keywords.

Library                         OperatingSystem
Library                         DatabaseLibrary
Library                         Collections
Library                         Selenium2Library
#Library                         Dialogs
Library                         Process
Library                         SSHLibrary
Library                         HttpLibrary.HTTP
Library                         String
Variables                       ../variables/global_variables.py


*** Keywords ***
# Docker
Restart Docker
    [Arguments]                             ${container}
    Run                                      docker restart ${container}

# Browser
Open Chrome
    [Arguments]    ${url}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #Call Method    ${chrome_options}    add_argument    headless
    #Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${url}

# Open Browser To Landing Page
#     Open Browser                            ${WORKING_URL}    ${BROWSER}
#     Maximize Browser Window
#     Set Selenium Speed                      ${DELAY}
#     Wait Until Element is Visible           left_menu   timeout=50s
#     Title Should Be                         Mobility
#     Element Should Not Be Visible           css=div.InfluencesPanel__empty

Open Browser To Login Page
    [Arguments]                             ${app}=app
    Open Chrome                             ${WORKING_URL}
    Maximize Browser Window
    Set Selenium Speed                      ${DELAY}
    Wait Until Element is Visible           kc-content   timeout=20s

Log In
    Selenium2Library.Input Text             username    ${VALID_USER}
    Selenium2Library.Input Password         password    ${VALID_PASSWORD}
    Click Button                            kc-login
    Wait Until Element is Visible           xpath://img[@src="img/logout.png"]   timeout=10s

Log Out
    Click Element                           xpath://img[@src="img/logout.png"]
    Wait Until Element is Visible           kc-content   timeout=10s


# API QUERIES
Authentication
    [Arguments]                             ${user}=admin    ${pass}=CidHafnisearwybnetcytval
    ${TOKEN} =                              Get Token    ${user}    ${pass}
    Create HTTP Context                     ${SERVER}    ${SCHEME}
    Set Request Header                      Authorization    Bearer ${TOKEN}
    Set Request Header                      accept    application/json
    Set Request Header                      content-type    application/json

Get KPIs
    [Arguments]                             ${QUERY}
    Authentication
    GET                                     ${QUERY}
    ${body} =                               Get Response Body
    ${json} =    Parse Json                 ${body}
    [Return]                                ${json["rows"]}

Get Token
    [Arguments]                             ${user}=admin    ${pass}=CidHafnisearwybnetcytval
    Create HTTP Context                     ${SERVER}    ${SCHEME}
    Set Request Body                        grant_type=password&client_id=mobility-web-app&username=${user}&password=${pass}&client_secret=008c5f69-25d6-4263-b77d-39b8d46af46a
    POST                                    /auth/realms/worldsensing-mobility/protocol/openid-connect/token
    ${RESULT} =                             Get Response Body
    ${TOKEN} =                              Get Json Value    ${RESULT}    /access_token
    ${TOKEN} =    Replace String            ${TOKEN}    "    ${EMPTY}
    [Return]                                ${TOKEN}

# Assertions
Assert Response
    [Arguments]                             ${status_code}    ${response_body}
    Response Status Code Should Equal       ${status_code}
    Response Body Should Contain            ${response_body}

# General
Download a file
    [Arguments]     ${name}    ${img src}
    ${rc}           ${output}    Run And Return Rc And Output    wget --cookies=on -O ${name} ${img src}
    Log             ${rc}
    Log             ${output}
    Move File       ${name}    /tmp/

Compare Images
   [Arguments]      ${Reference_Image_Path}    ${Test_Image_Path}    ${Allowed_Threshold}
   ${TEMP}=         Replace String     ${IMAGE_COMPARATOR_COMMAND}    __REFERENCE__     ${Reference_Image_Path}
   ${COMMAND}=      Replace String     ${TEMP}    __TEST__     ${Test_Image_Path}
   ${RC}            ${OUTPUT}=     Run And Return Rc And Output     ${COMMAND}
   ${RESULT}        Evaluate    ${OUTPUT} < ${Allowed_Threshold}
   Should be True   ${RESULT}    msg=${Reference_Image_Path} NOT EQUAL TO ${Test_Image_Path}

Open Connection And Login
    Open Connection           ${SERVER}
    Login With Public Key     ${ssh_user}    ${ssh_path}/.ssh/id_rsa


# TODO use leaflet and javascript to center map
Center The Map At Element
    [Arguments]             ${coordinates}    ${zoom}
    Execute Javascript    map.panTo(${coordinates})

Reset Map To Default
    Open Connection And Login
    Execute Command           sed -i 's/defaultCoordinates: \\[[0-9]\\+\\.[0-9]\\+, [0-9]\\+\\.[0-9]\\+\\]/defaultCoordinates: \\[41.390205, 2.15400\\]/g' /var/opt/mb/webapp_conf/userConfigurations.yaml
    Execute Command           sed -i "s/defaultZoom: [0-9]\\+/defaultZoom: 12/g" /var/opt/mb/webapp_conf/userConfigurations.yaml
    Close Connection

Backup Default userConfigurations
    Open Connection And Login
    Execute Command           mv /var/opt/mb/webapp_conf/userConfigurations.yaml /var/opt/mb/webapp_conf/userConfigurations.yaml.bkp
    Close Connection

Restore Default userConfigurations
    Open Connection And Login
    Execute Command           mv /var/opt/mb/webapp_conf/userConfigurations.yaml.bkp /var/opt/mb/webapp_conf/userConfigurations.yaml
    Close Connection

Copy Asset
    [Arguments]               ${source}    ${destination}
    Open Connection And Login
    Put File                  ${source}    ${destination}
    Close Connection

Copy Directory
    [Arguments]               ${source}    ${destination}
    Open Connection And Login
    Put Directory             ${source}    ${destination}    mode=0775    recursive=True
    Execute Command           chmod 0775 -R ${destination}
    Close Connection

Remove Directory
    [Arguments]               ${directory}
    Open Connection And Login
    Execute Command           rm -rf ${directory}
    Close Connection
