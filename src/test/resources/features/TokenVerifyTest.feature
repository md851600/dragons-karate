#Scenario 5:
#endpoint = /api/token/verify
#With a valid token you should get response HTTP Status Code 200 and response true
# in here we are doing two steps one we automating to get the token then we send the request using that token
#to add parameters to request
@Smoke @Regression
Feature: Token Verify Test

  Background: Setup test url
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify Valid Token
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post # the post method is to get the token
    #Validating response
    Then status 200
    And print response
    # second reguest
    Given path "api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response

  #Scenario 6:Endpoint = /api/token/verify
  #With valid token and invalid username you should get response HTTP Status Code 400
  #and error message "Wrong Username send along with Token"
  Scenario: Nagative test Validation token verify with wrong username
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post # the post method is to get the token
    #Validating response
    Then status 200
    And print response
    # second reguest
    Given path "api/token/verify"
    And param token = response.token
    And param username = "supervisor123"
    When method get
    Then status 400
    And print response

  #Scenario 7:Endpoint = /api/token/verify
  #with invalid token and valid username should have Status code 400
  #and error Message "Token Expired or Invalid Token"
  Scenario: Nagative test Varify Token with invalid token and valid username
    Given path "api/token/verify"
    And param token = "Invalid_ token"
    And param username = "supervisor"
    And method get
    Then status 400
    And print response
    And assert response.errorMessage =="Token Expired or Invalid Token"
    
    
    
    
