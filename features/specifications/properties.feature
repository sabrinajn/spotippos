Feature: Create property 
  As the spotippos system
  In order to add properties in the system
  I need a webservice to create properties

  Scenario: successful create
    When I send a POST request to "/properties" with valid params
    Then the status code response should be "201"
    And the property should be created
