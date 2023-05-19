Feature: EnD 2 End Account Testing
Background: API Test 
    * def result = callonce read('GenerateToken.feature')
    * def token =  result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account With Random Email
    * def dataGenerator = Java.type('api.data.GenereteData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
      "email": "#(autoEmail) ",
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
    And assert response.email == autoEmail
    
    Given path "api/accounts/add-account-address"
    And param primaryPersonId = response.id
    And header Authoe
