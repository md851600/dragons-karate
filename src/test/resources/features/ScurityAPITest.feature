@Smoke @Regression
Feature: API Test Security Section

  Background: Setup Request url
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  
  Scenario: Create token with valid username and password.
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
     And print response

  Scenario: Validate Token with Invalid username
    And request {"username": "Notsupervisor","Password": "tek_supervisor"}
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage=="User not found"

  Scenario: Validate Token with valid username and Invalid password
    And request {"username": "supervisor","password": "tek_supervisor123"}
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.httpStatus== "BAD_REQUEST"
    And assert response.errorMessage == "Password Not Matched"
