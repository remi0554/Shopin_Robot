*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/base_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/login_page.robot
Resource    ../pages/cart_page.robot
Resource    ../pages/alert_page.robot

*** Variables ***
${Browser}    Chrome

*** Test Cases ***
Add Elements To Cart
    [Documentation]    authenticate and add elements to cart
    [Tags]    cart
    access To URL    ${Browser}
    Sleep    2s
    login2
    Sleep    2s
    Add Element To Cart By Name    "Brown Cap"
    Sleep    2s
Add New Elements To Cart
    [Documentation]    authenticate, add elements to cart and add new ones
    [Tags]    cart
    access To URL    ${Browser}
    Sleep    2s
    Login1
    Sleep   2s
    Add Element To Cart By Name    "Elegant Bag"
    Sleep    2s
Add Third Element To Cart
    [Documentation]    authenticate, add elements to cart and add new ones
    [Tags]    cart
    access To URL    ${Browser}
    Sleep    2s
    Login1
    Sleep    2s
    Add Element To Cart By Name    "Casquette de running"

Reduce Elements Quantity From Cart
    [Documentation]    authenticate, add elements to cart and delete them
    [Tags]    Quantity
    View Cart
    Sleep    2s
    Remove Item From Cart    "Brown Cap"
    Sleep    5s

Add Elements Quantity To Cart
    [Documentation]    authenticate, add elements to cart and increase their quantity
    [Tags]    Quantity
    View Cart
    Sleep    2s
    Add Item quantity    "Elegant Bag"
    Sleep    5s

Try Promo Code
    [Documentation]    authenticate, add elements to cart and try promotion code
    [Tags]    PROMO Test
    Go To Boutique Page
    Sleep    2s
    View Cart
    Sleep    2s
    Click Cookie Confirm
        Sleep    1s
    Scroll Down 15cm
    Try Promotion Code
        Sleep    5s


Check Promo Code
    [Documentation]    Le code promo "PROMO" applique une réduction de 15 %
    [Tags]    promotion
    Scroll Down 15cm
    Sleep    2s
    check If Promo_Code is Applied
    sleep    2s

cart operations
    View Cart
    View Total price
  
Close Browser
    End Web Test