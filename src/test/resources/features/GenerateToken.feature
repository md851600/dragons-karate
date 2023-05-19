Feature: Generate token

  Scenario: generate  a valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post # the post method is to get the token
    #Validating response
    Then status 200
    And print response
    #def step is to define new veriable in karate framework
    
