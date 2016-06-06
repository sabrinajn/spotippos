Feature: Get property
  As the spotippos system
  In order to show properties in the system
  I need a webservice to get property

  Background:
    Given there are no properties
    And I add properties with the following attributes:
      | x   | y    | title                             | price  | description | beds | baths | square_meters | id |
      | 667 | 556  | Imovel com 1 quarto e 1 banheiro  | 540000 | Lorem ipsum.| 1    | 1     | 42            | 1  |

  Scenario: successful search path
    When I send a GET request to "/properties/1"
    Then the status code response should be "200"
    And the response body with the following JSON:
    """
    {
      "id": 1,
      "title": "Imovel com 1 quarto e 1 banheiro",
      "price": 540000,
      "description": "Lorem ipsum.",
      "x": 667,
      "y": 556,
      "beds": 1,
      "baths": 1,
      "provinces" : ["Ruja"],
      "squareMeters": 42
    }
    """

  Scenario: failure when property not found
    When I send a GET request to "/properties/2"
    Then the status code response should be "404"
    And the response should have error "property not found"
