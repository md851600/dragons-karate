@Regression
Feature: Create Account Test

  Background: API test setup
    # callonce read is karate steps to execute and read another feature file
    #the result of callonce can store into new variable using def step
    * def result = callonce read("GenerateToken.feature")
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "Abeda.Hazim77@tekschool.us",
      "firstName": "Abeda",
      "lastName": "Hazim",
      "title": "Mrs",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "student",
      "dateOfBirth": "1997-03-31"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == "Abeda.Hazim77@tekschool.us"
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
