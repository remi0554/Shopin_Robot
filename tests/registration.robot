*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/base_page.robot
Resource    ../pages/register_page.robot


*** Variables ***
${Browser}    headless-chrome     # headless for CI, chrome for local                     # Chrome
${Used_Mail}    remitgm@gmail.com

*** Test Cases ***

Account Creation with Used Email
    [Documentation]    Go to shopin registration page, try to create an account with random username and password but used email, and check that error message is visible
    Access To URL    ${Browser}
    Sleep    4s
    Go To    https://shop-in.ovh/mon-compte/

Create New Account with used email
    [Documentation]    Un email déjà utilisé empêche la création d'un nouveau compte
    Create Account with Random Credentials and Used Email    ${Used_Mail}

Check Error Message Is Visible
    [Documentation]    Check that the error message is visible after attempting to create an account with a used email
    Assert Error Message Is Visible