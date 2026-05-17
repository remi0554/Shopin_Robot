*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/alert_page.robot
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/price-del_page.robot

*** Variables ***
${Browser}    Chrome
${Product_Reference}    532


*** Test Cases ***

Go To Accessories Page Crossed Prices
    [Documentation]    Go to accessories page and select snapback cap
    Access To URL    ${Browser}
    Sleep    2s
    Go To Accessories Page
    Sleep    2s
    Scroll Down 5cm
    # Check The Previous Price Is Displayed    532
    Sleep    2s


Verify Snapback Cap Has Two Prices
    [Documentation]    Verify product shows both original and discounted price
    Scroll Down 15cm
    Sleep    2s
    Click Cookie Confirm
    Check Product Has Two Prices With One Crossed    ${Product_Reference}
