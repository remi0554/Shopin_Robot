*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${Cookie_Confirm_BTN}    xpath=//button[@class='ct-button ct-cookies-accept-button']

*** Keywords ***
Click Cookie Confirm
    
    Wait Until Element Is Visible    ${Cookie_Confirm_BTN}
    Click Button    ${Cookie_Confirm_BTN}