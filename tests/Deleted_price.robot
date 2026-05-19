*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/alert_page.robot
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/price-del_page.robot

*** Variables ***
${Browser}    Chrome    # headless-chrome      headless for CI, chrome for local                     # 
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


Verify Product Has Two Prices
    [Documentation]    Les produits en promotion doivent afficher le prix d'origine barré et le prix de vente
    Scroll Down 15cm
    Sleep    2s
    Click Cookie Confirm
    Check Product Has Two Prices With One Crossed    ${Product_Reference}
