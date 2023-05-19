@Regression
Feature: Test Get Account

  Background: Setup Request
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: get Account API call
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post # the post method is to get the token
    #Validating response
    Then status 200
    And print response
    #def step is to define new veriable in karate framework
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId  = 6867;
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id ==6867
