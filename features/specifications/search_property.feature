Feature: Search property
  As the spotippos system
  In order to search properties in the system
  I need a webservice to search property

  Background:
    Given there are no properties
    And I add properties with the following attributes:
      | x    | y    | title                             | price  | description | beds | baths | square_meters | id  |
      | 667  | 556  | Imovel com 1 quarto e 1 banheiro  | 340000 | Lorem ipsum.| 1    | 1     | 42            | 101 |
      | 100  | 700  | Imovel com 2 quarto e 1 banheiro  | 440000 | Lorem ipsum.| 2    | 1     | 52            | 290 |
      | 960  | 259  | Imovel com 3 quarto e 2 banheiro  | 840000 | Lorem ipsum.| 3    | 2     | 72            | 122 |
      | 1000 | 800  | Imovel com 4 quarto e 3 banheiro  | 940000 | Lorem ipsum.| 4    | 3     | 120           | 390 |

  Scenario: successful search path
    When I send a GET request to "/properties?ax=100&ay=700&bx=700&by=300"
    Then the status code response should be "200"
    And the response body with the following JSON:
    """
    { "foundProperties": 2,
      "properties": [
                        { "id": 101,
                          "title": "Imovel com 1 quarto e 1 banheiro",
                          "price": 340000,
                          "description": "Lorem ipsum.",
                          "x": 667,
                          "y": 556,
                          "beds": 1,
                          "baths": 1,
                          "provinces": ["Ruja"],
                          "squareMeters": 42
                        },
                        { "id": 290,
                          "title": "Imovel com 2 quarto e 1 banheiro",
                          "price": 440000,
                          "description": "Lorem ipsum.",
                          "x": 100,
                          "y": 700,
                          "beds": 2,
                          "baths": 1,
                          "provinces": ["Gode"],
                          "squareMeters": 52
                        }
                    ]
    }
    """

  Scenario: failure when property not found
    When I send a GET request to "/properties?ax=0&ay=600&bx=500&by=300"
    Then the status code response should be "200"
    And the response body with the following JSON:
    """
    {
      "foundProperties": 0,
      "properties": []
    }
    """
