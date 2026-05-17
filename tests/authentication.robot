
*** Settings ***
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/login_page.robot

*** Variables ***
${Browser}    Chrome

*** Test Cases ***
Authentication With Valid Credentials
    Access To URL    ${Browser}
    Sleep    2s
    Login
    Sleep    2s

Verify Message Is Visible
    Verify Element Is Visible

    [Documentation]    Test to verify welcome message appears after login
    [Tags]    visibility
