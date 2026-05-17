*** Settings ***

Library    SeleniumLibrary


*** Variables ***

${MENU_XPATH}    //a[@aria-label='Add to cart: “{}”']
${Boutique}    id=menu-item-689
${Boutique_Accessoires}    id=menu-item-1553
${TIMEOUT}    10s

*** Keywords ***

Go To Boutique Page

    Click Element    ${Boutique}

Add Element To Cart By Name 
    [Arguments]      ${MENU_NAME}
    Click Element    ${Boutique}
    ${Menu_Element}=                  Get WebElement    xpath:${MENU_XPATH.format(${MENU_NAME})}
    Execute JavaScript    window.scrollBy(0, 500)
    Sleep    1s
    Scroll Element Into View         ${Menu_Element}
    Execute JavaScript    document.querySelector('.woocommerce-store-notice').style.display = 'none';
    Click Element                    ${Menu_Element}

Go To Accessories Page
    [Documentation]    Hover over Boutique then click Accessories submenu then click on a specific product

    Wait Until Element Is Visible    ${Boutique}       timeout=${TIMEOUT}
    Mouse Over                       ${Boutique}
    Wait Until Element Is Visible    ${Boutique_Accessoires}    timeout=${TIMEOUT}
    Click Element                    ${Boutique_Accessoires}
    Wait Until Page Contains         Accessories            timeout=${TIMEOUT}
