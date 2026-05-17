*** Settings ***
Library    SeleniumLibrary
Library    String
Library    ../helper/env_reader.py

*** Variables ***

${Username_INPUT}    id=reg_username
${Email_INPUT}    id=reg_email
${Password_INPUT}    id=reg_password
${Register_BTN}    name=register
${Error_Message}    xpath=//main[@id='main']//li[1]


*** Keywords ***

Generate Random username
    ${username}=    Generate Random String    5    [LOWER]
    Log    Generated username: ${username}    level=INFO
    RETURN    ${username}

Generate Random Password
    ${password}=    Generate Random String    12    [LETTERS]!@#$%[NUMBERS]
    Log    Generated password: ${password}    level=INFO
    RETURN    ${password}

Create Account with Random Credentials and Used Email

    [Documentation]    Create an account with random username and password and used email adress
    [Arguments]    ${Mail}

    ${username}=    Generate Random username
    ${password}=    Generate Random Password
    Input Text    ${Username_INPUT}     ${username}
    Input Text    ${Email_INPUT}        ${Mail}
    Input Text    ${Password_INPUT}     ${password}
    Click Button    ${Register_BTN}
    Sleep    2s

Assert Error Message Is Visible

    [Documentation]    Assert that error message is visible after trying to create an account with used email
    Wait Until Element Is Visible    ${Error_Message}    timeout=10s
    ${error_text}=    Get Text    ${Error_Message}
    Log    Error message: ${error_text}    level=INFO
    Should Contain    ${error_text}    An account is already registered with your email address.

    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    Capture Page Screenshot    filename=RP_Screenshots/registration_error_${timestamp}.png