*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/price-del_page.robot

*** Variables ***
${Browser}    Chrome


*** Test Cases ***

Go To Accessories Page Crossed Prices
    [Documentation]    Go to accessories page and select snapback cap
    Access To URL    ${Browser}
    Sleep    2s
    Go To Accessories Page
    Sleep    2s
    Scroll Down 5cm
    Check The Previous Price Is Displayed    532
    Sleep    2s

Verify Snapback Cap Has Sale Price Crossed Out
    [Documentation]    Verify that the snapback cap has a sale price and that the original
    ${on_sale}=    Product Has Original Price    532
    IF    ${on_sale}
        Log    Product is ON SALE    level=INFO
        ${raw_original}=    Get Text    xpath=//li[contains(@class,'post-532')]//del//bdi
        ${original}=        Evaluate    "${raw_original}".replace("€", "").strip()
        Log    Original price was: ${original}    level=INFO
    ELSE
        Log    Product is NOT on sale    level=INFO
    END