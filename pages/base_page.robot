*** Settings ***
Library    SeleniumLibrary
Library    ../helper/env_reader.py  

*** Variables ***
${BROWSER}      chrome
${HEADLESS}     false       # change to true for CI

*** Keywords ***
Access To URL
    ${URL}=       Get Env    URL
    ${options}=   Evaluate    selenium.webdriver.ChromeOptions()    selenium
    Run Keyword If    '${HEADLESS}' == 'true'    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Implicit Wait    20s

Scroll Down 5cm
    Execute Javascript    window.scrollBy(0, 190)

Scroll Down 15cm
    Execute Javascript    window.scrollBy(0, 800)

End Web Test
    Close All Browsers