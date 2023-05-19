@Regression
Feature: Get all plan code

  Background: 
   * def result = callonce read("GenerateToken.feature")
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Test get all plan
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + generatedToken
    When method get
    And status 200
    And print response
