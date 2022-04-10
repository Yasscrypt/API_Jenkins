*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot

*** Keywords ***

Verifier si l'utilisateur existe dans la bdd
    Connect To Database Using Custom params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1

Authentifier un utilisateur dans l'application
    Create Session  session3  ${WEBSITE_LINK}
    ${response} =  GET On Session  session3  url=/${WEBSITE_LINK}/login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    Log  ${json}
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${json['message']}  Successfully Login!

Supprimer utilisateur dans la bdd
    Connect To Database Using Custom params  pymysql  database='demo', user='root', password='', host='localhost'
    Execute Sql String  DELETE FROM users WHERE username = '${USERNAME}' and password = md5('${PASSWORD}')
    Disconnect From Database

Authentifier un utilisateur inexistant dans l'application
    Create Session  session4  ${WEBSITE_LINK}
#    ${response} =  Get Request  session4  login.php?username=${USERNAME}&password=${PASSWORD}
    ${response} =  GET On Session  session4  url=/${WEBSITE_LINK}/login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${json['message']}  Invalid Username or Password!