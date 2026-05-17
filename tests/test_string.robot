*** Settings ***
Library    String
Resource    ../pages/login_page.robot
Resource    ../pages/base_page.robot
Resource    ../pages/cart_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/price-del_page.robot

*** Test Cases ***
Test Random String

    ${result}=    Generate Random String    8    [LETTERS][NUMBERS]
    Log    ${result}    level=INFO

Test Random Username
    Access To URL    Chrome
    login
    Verify Element Is Visible

check initial price is crossed-out
    Go To Boutique Page
    Sleep    2s
    Go To Accessories Page    "Snapback Cap"
    Sleep    2s
# cart operations
#     View Cart
#     View Total price
#     Reload Page
#     sleep    2s
#     View Total price
#     Reload Page
#     sleep    2s
#     View Total price
#     Reload Page
#     sleep    2s
#     Reload Page

