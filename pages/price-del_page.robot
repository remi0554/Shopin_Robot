*** Settings ***

Library    SeleniumLibrary
Library    string
Library    ../helper/env_reader.py  

*** Variables ***
${product_container}    xpath=//li[contains(@class,'product') and contains(@class,'post-532')]
${sale_price_del}       xpath=//li[contains(@class,'product') and contains(@class,'post-532')]//del[@aria-hidden="true"]
${Articles}    //li[contains(@class,'post-{}')]

*** Keywords ***

Check The Previous Price Is Displayed
    [Documentation]    Check if the original price is displayed for a specific product
    [Arguments]      ${Reference}
    ${Menu_Element}=                  Get WebElement    xpath:${Articles.format(${Reference})}
    Execute JavaScript    window.scrollBy(0, 1000)
    Sleep    1s
    Scroll Element Into View         ${Menu_Element}
    Execute JavaScript    document.querySelector('.woocommerce-store-notice').style.display = 'none';
    Sleep    5s
    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    Capture Element Screenshot                    ${Menu_Element}    filename=PDP_Screenshots/total_price_${timestamp}.png


Product Has Original Price
    [Documentation]    Check if a specific product has a strikethrough price
    [Arguments]    ${product_id}
    ${sale_locator}=    Set Variable    xpath=//li[contains(@class,'post-${product_id}')]//del[@aria-hidden="true"]
    ${exists}=          Run Keyword And Return Status
    ...                 Page Should Contain Element    ${sale_locator}
    Log    Product ${product_id} has original price: ${exists}    level=INFO
    RETURN    ${exists}
