@Regression
Feature: Api Accounts

  Background: API Test
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def token =  result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Api Accounts All Accounts
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
