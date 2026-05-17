*** Settings ***

Library    SeleniumLibrary
Library    string
Library    ../helper/env_reader.py  

*** Variables ***

${click_logo}       //*[name()='path' and contains(@d,'M7.5,0C3.4')]
${username_elem}    id=username
${password_elem}    id=password
${btn_elem}        xpath=//button[@name='login']
${welcome_locator}      xpath=//p[contains(text(),'Hello')]
${Username_Message}    Hello remitgm

*** Keywords ***

login

          ${username}=    Get Env    USERNAMES
          ${password}=    Get Env    PASSWORDS
          Click Element    ${click_logo}
          Input Text    ${username_elem}     ${username}
          Input Text    ${password_elem}     ${password}
          Wait Until Element Is Visible    ${btn_elem} 
          Click Button    ${btn_elem} 

Verify Element Is Visible
    [Documentation]    Verify the welcome message appears after login
    
    Wait Until Element Is Visible    ${welcome_locator}    timeout=10s
    
    ${welcome_text}=    Get Text    ${welcome_locator}
    Log    Welcome message: ${welcome_text}    level=INFO
    
    # Verify content
    Should Contain    ${welcome_text}    ${Username_Message}
    Should Contain    ${welcome_text}    Log out
    
    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    Capture Page Screenshot    filename=LP_Screenshots/welcome_verified_${timestamp}.png