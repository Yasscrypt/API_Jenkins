*** Settings ***
Resource  ../ressources/signupBack.robot
Resource  ../ressources/loginBack.robot
Resource  ../ressources/variables.robot

*** Test Cases ***
Inscrire un utilisateur
    signupBack.Verifier si l'utilisateur n'existe pas dans la bdd
    signupBack.Inscription utilisateur par une requette Http POST
    signupBack.Verifier que l'utilisateur est ajouté dans la bdd

Inscrire le même utilisateur

    signupBack.Inscription du même utilisateur par une requette Http POST
    signupBack.Verifier que l'utilisateur n'est pas dupliqué dans la bdd

Authentifier utilisateur

    loginBack.Verifier si l'utilisateur existe dans la bdd
    loginBack.Authentifier un utilisateur dans l'application

Supprimer utilisateur

    loginBack.Supprimer utilisateur dans la bdd
    loginBack.Authentifier un utilisateur inexistant dans l'application



