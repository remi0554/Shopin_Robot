*** Settings ***

Library    SeleniumLibrary
Library    string
Library    ../helper/env_reader.py  

*** Variables ***
${product}            xpath=//li[contains(@class,'post-{}')]
${original_price}     xpath=//li[contains(@class,'post-{}')]//del[@aria-hidden="true"]//bdi
${Hidden}               xpath=//del[@aria-hidden="true"]
${sale_price}         xpath=//li[contains(@class,'post-{}')]//ins//bdi


*** Keywords ***

Check Product Has Two Prices With One Crossed
    [Documentation]    Verify product has both original (crossed) and sale price
    [Arguments]    ${Reference}

    ${original_price}=    Set Variable    xpath=//li[contains(@class,'post-${Reference}')]//del[@aria-hidden="true"]//bdi
    ${sale_price}=        Set Variable    xpath=//li[contains(@class,'post-${Reference}')]//ins//bdi

    # Actual assertions using Run Keyword And Return Status
    ${has_crossed}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${original_price}
    Should Be True    ${has_crossed}    msg=No crossed out price found

    ${has_sale}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${sale_price}
    Should Be True    ${has_sale}    msg=No sale price found

    # Get values
    ${raw_original}=    Get Text    ${original_price}
    ${raw_sale}=        Get Text    ${sale_price}

    ${original}=    Evaluate    "${raw_original}".replace("€", "").strip()
    ${sale}=        Evaluate    "${raw_sale}".replace("€", "").strip()

    Should Be True    ${original} > ${sale}
    ...    msg=Original €${original} should be greater than sale €${sale}

    Log    Crossed price: €${original}    level=INFO
    Log    Sale price: €${sale}           level=INFO
    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    ${Menu_Element}=                  Get WebElement    ${product.format(${Reference})}
    Capture Element Screenshot                    ${Menu_Element}    filename=PDP_Screenshots/product_price_${timestamp}.png
    Capture Page Screenshot    filename=PDP_Screenshots/product_page_${timestamp}.png
