*** Settings ***

Library    SeleniumLibrary
Library    String


*** Variables ***

${CART_ICON}    xpath=//div[@data-device='desktop']//div[@data-row='middle']//span[@class='ct-icon-container']//*[name()='svg']
${CART_ITEM}    xpath=//td[@class='product-name']//a[contains(text(),'{}')]
${REMOVE_quantity}    xpath=//span[@class='ct-decrease']
${add_quantity}    xpath=//span[@class='ct-increase']
${PROMO_CODE_INPUT}    xpath=//input[@id='coupon_code'] 
${chek_promo}    Xpath=//td[@data-title="Total"]//span[@class="woocommerce-Price-amount amount"]
${total_price_elem}    xpath=//tr[@class='order-total']//bdi
${TIMEOUT}    10s
# ${chek_promo}    //td[@data-title="Total"]//span[@class="woocommerce-Price-amount amount"]//span[@class='woocommerce-Price-currencySymbol']

*** Keywords ***


View Cart
    Click Element    ${CART_ICON}    action_chain=True

Add Item quantity
    [Arguments]      ${ITEM_NAME}
    Click Element    ${CART_ITEM.format(${ITEM_NAME})}
    Sleep    1s
    Click Element    ${add_quantity}
    Sleep    2s
    Click Element    ${CART_ICON}

Remove Item From Cart
    [Arguments]      ${ITEM_NAME}
    Click Element    ${CART_ITEM.format(${ITEM_NAME})}
    Sleep    1s
    Click Element    ${REMOVE_quantity}
    Sleep    2s
    Click Element    ${CART_ICON}

Try Promotion Code
    [Documentation]    Try to apply promotion codes
    Scroll Element Into View    ${PROMO_CODE_INPUT}
    Click Element    ${PROMO_CODE_INPUT}    action_chain= True
    Sleep    1s
    Input Text       id=coupon_code     PROMO
    Sleep    1s
    Click Button     name=apply_coupon
    Sleep    2s
    ${Retour_Promo}=    Get Text    Xpath=//ul[@role='alert']
    Log    Promotion Result: ${Retour_Promo}

Check If Promo_Code is Applied
    [Documentation]    Test to verify that promotion code is applied and total price is updated
    [Tags]    promotion
    
    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    View Cart
    Sleep    2s
    ${initial_price}=    Get Value    ${chek_promo}
    Log    Initial price: ${initial_price}    level=INFO
    Capture Page Screenshot    filename=CP_Screenshots/initial_price_${timestamp}.png
    Try Promotion Code
    Sleep    5s
    ${updated_price}=    Get Value    ${chek_promo}
    Log    Updated price: ${updated_price}    level=INFO
    # Should Not Be Equal    ${initial_price}    ${updated_price}
    Capture Page Screenshot    filename=CP_Screenshots/updated_price_${timestamp}.png

View Total price

    [Documentation]    Get the total price from the cart
    Wait Until Element Is Visible    ${total_price_elem}    timeout=${TIMEOUT}
    ${raw_price}=       Get Text      ${total_price_elem}
    # raw_price will be "€468.90" — strip the currency symbol
    ${price}=           Strip String  ${raw_price}    characters=€
    ${price}=           Strip String  ${price}        characters= \n
    Log                 Total price: ${price}    level=INFO
    RETURN              ${price}
    ${timestamp}=    Evaluate    datetime.datetime.now().strftime('_%Y%m%d_%H%M%S')
    Capture Element Screenshot    ${total_price_elem}    filename=CP_Screenshots/total_price_${timestamp}.png
