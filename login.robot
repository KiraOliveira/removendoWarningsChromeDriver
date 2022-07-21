*** Settings ***
Documentation    Removendo os Warnings do ChromeDriver

Library    SeleniumLibrary

# Gancho
Suite Setup    Abrir navegador

# é do Selenium
Suite Teardown    Close Browser    

*** Variables ***
${browser}    chrome
#${url}       https://training-wheels-protocol.herokuapp.com
${timeout}    10

*** Test Cases ***
Login feliz
    Login With                  stark                                           jarvis!
    Wait Until Page Contains    Olá, Tony Stark. Você acessou a área logada!    timeout=${timeout} 

Senha inválida
    Login With                  stark                abc123
    Wait Until Page Contains    Senha é invalida!    timeout=${timeout}

Usuário não existe
    Login With                  paito                                       jarvis!
    Wait Until Page Contains    O usuário informado não está cadastrado!    timeout=${timeout}

*** Keywords ***
 # Gancho
Abrir navegador
    Open Browser    about:blank    ${browser}    options=add_experimental_option('excludeSwitches', ['enable-logging'])

# Encapsulamento
Login With
    [Arguments]    ${username}    ${pass}

    Go To    https://training-wheels-protocol.herokuapp.com/login

    Input Text    id:userId    ${username}
    Input Text    id:passId    ${pass}

    Click Element    class:btn-login    