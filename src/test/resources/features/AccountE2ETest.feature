@Regression
Feature: EnD 2 End Account Testing

  Background: API Test
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def token =  result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account creation Testing
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
    * def genratedAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = genratedAccountId
    And header Authorization = "Bearer " + token
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "2666 cottage ",
      "city": "Sacramento",
      "state": "California",
      "postalCode": "212134",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "2666 cottage "
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = genratedAccountId
    And header Authorization = "Bearer " + token
    * def randomPhoneNumber = dataGenerator. getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(randomPhoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Mornig",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == randomPhoneNumber
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = genratedAccountId
    And header Authorization = "Bearer " + token
    * def randomLicenseplate = dataGenerator. getNumberPlate()
    And request
      """
      {
      "make": "Ford",
      "model": "Mustang",
      "year": "2023",
      "licensePlate": "#(randomLicenseplate)"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == randomLicenseplate
