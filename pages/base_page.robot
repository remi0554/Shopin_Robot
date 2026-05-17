*** Settings ***
Library    SeleniumLibrary
Library    ../helper/env_reader.py  

*** Keywords ***
Access To URL
    
    [Arguments]    ${Browser}
    
    ${URL}=    Get Env    URL
    Open Browser     ${URL}    ${Browser}
    Maximize Browser Window
    Set Selenium Implicit Wait     20s

Scroll Down 5cm
    Execute Javascript    window.scrollBy(0, 190)

End Web Test
    Close All Browsers