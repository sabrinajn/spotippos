Feature: Create property
  As the spotippos system
  In order to add properties in the system
  I need a webservice to create properties

  Scenario: successful create
    When I send a POST request to "/properties" with:
    """
    {
      "x": 222,
      "y": 444,
      "title": "Imovel codigo 1, com 5 quartos e 4 banheiros",
      "price": 1250000,
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "beds": 4,
      "baths": 3,
      "squareMeters": 210
    }
    """
    Then the status code response should be "201"
    And the property should be created

  Scenario: Failure when does not send params
    When I send a POST request to "/properties" without params
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    { "errors": {
                  "title": ["can't be blank"],
                  "description": ["can't be blank"],
                  "x": ["is not a number"],
                  "y": ["is not a number"],
                  "price": ["is not a number"],
                  "beds": ["is not a number"],
                  "baths": ["is not a number"],
                  "square_meters": ["is not a number"]
                }
    }
    """

  Scenario Outline: failure when invalid params
    When I send a POST request to "/properties" with:
    """
    {
      "x": <x>,
      "y": <y>,
      "title": "<title>",
      "price": "<price>",
      "description": "<description>",
      "beds": <beds>,
      "baths": <baths>,
      "squareMeters": <square_meters>
    }
    """
    Then the status code response should be "400"
    And  the response should have error for "<field>" with "<message_error>"

    Examples:
      | x   | y    | title | price | description | beds | baths | square_meters | field        | message_error                      |
      | -1  | 100  | text  | 10000 | text        | 2    | 1     | 60            | x            | must be greater than or equal to 0 |
      | 1401| 100  | text  | 10000 | text        | 2    | 1     | 60            | x            | must be less than or equal to 1400 |
      | 100 | -1   | text  | 10000 | text        | 2    | 1     | 60            | y            | must be greater than or equal to 0 |
      | 100 | 1001 | text  | 10000 | text        | 2    | 1     | 60            | y            | must be less than or equal to 1000 |
      | 100 | 1000 |       | 10000 | text        | 2    | 1     | 60            | title        | can't be blank                     |
      | 100 | 1000 | text  | 0     | text        | 2    | 1     | 60            | price        | must be greater than 0             |
      | 100 | 1000 | text  | 10000 |             | 2    | 1     | 60            | description  | can't be blank                     |
      | 100 | 1000 | text  | 10000 | text        | 0    | 1     | 60            | beds         | must be greater than or equal to 1 |
      | 100 | 1000 | text  | 10000 | text        | 6    | 1     | 60            | beds         | must be less than or equal to 5    |
      | 100 | 1000 | text  | 10000 | text        | 2    | 0     | 60            | baths        | must be greater than or equal to 1 |
      | 100 | 1000 | text  | 10000 | text        | 2    | 5     | 60            | baths        | must be less than or equal to 4    |
      | 100 | 1000 | text  | 10000 | text        | 2    | 1     | 19            | square_meters| must be greater than or equal to 20|
      | 100 | 1000 | text  | 10000 | text        | 2    | 1     | 241           | square_meters| must be less than or equal to 240  |

  Scenario: Failure when property already exists
    Given exists property with x "400" and y "600"
    When I send a POST request to "/properties" with:
    """
    {
      "x": 400,
      "y": 600,
      "title": "Imovel codigo 1, com 5 quartos e 4 banheiros",
      "price": 1250000,
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "beds": 4,
      "baths": 3,
      "squareMeters": 210
    }
    """
    Then the status code response should be "409"
    And the response should have error "property already exists"

