*** Settings ***
Library    SeleniumLibrary
Library    ../helper/env_reader.py  

*** Variables ***
${BROWSER}     chrome

*** Keywords ***
Access To URL
    
    [Arguments]    ${Browser}
    
    ${URL}=    Get Env    URL
    # Open Browser     ${URL}    ${Browser}

    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    selenium
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Call Method    ${options}    add_argument    --remote-debugging-port=9222
    Open Browser    ${URL}    ${BROWSER}    options=${options}

    Maximize Browser Window
    Set Selenium Implicit Wait     20s

Scroll Down 5cm
    Execute Javascript    window.scrollBy(0, 190)

Scroll Down 15cm
    Execute Javascript    window.scrollBy(0, 800)

End Web Test
    Close All Browsers
