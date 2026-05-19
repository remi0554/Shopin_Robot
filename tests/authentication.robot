
*** Settings ***
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/login_page.robot

*** Variables ***
${Browser}    Chrome    # headless-chrome      headless for CI, chrome for local                     # 

*** Test Cases ***
Authentication With Valid Credentials
    Access To URL    ${Browser}
    Sleep    2s
    Login1
    Sleep    2s

Verify Message Is Visible
    [Documentation]    Un message personnalisé doit s'afficher lors de la connexion d'un utilisateur existant
    [Tags]    visibility

    Verify Element Is Visible

    
