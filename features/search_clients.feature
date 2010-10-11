Feature: Search clients
  In order to quickly find clients
  An employee
  wants to be able to search for clients by name, address, and phone number
  
  Scenario: Search for last name
    Given I am on the clients page
    And I am an employee
    And the following clients:
      |first_name| last_name |
      |  Holden  | Caulfield |
      |  Phoebe  | Caulfield |
      |  Winston |   Smith   |
      |  Hiro    |Protagonist|
    When I fill in "search" with "Caulfield"
    And I press "Search"
    Then I should be on the clients page
    And I should see the following clients:
      | Last Name |First Name|
      | Caulfield |  Holden  |
      | Caulfield |  Phoebe  |
    And the "search" field should contain "Caulfield"

  Scenario: Search for first name
    Given I am on the clients page
    And I am an employee
    And the following clients:
      |first_name| last_name |
      |  Holden  | Caulfield |
      |  Phoebe  | Caulfield |
      |  Winston |   Smith   |
      |  Hiro    |Protagonist|
    When I fill in "search" with "Holden"
    And I press "Search"
    Then I should be on the clients page
    And I should see the following clients:
      | Last Name |First Name|
      | Caulfield |  Holden  |
    And the "search" field should contain "Holden"

  Scenario: Search for address
    Given I am on the clients page
    And I am an employee
    And the following clients:
      |first_name| last_name | address_1 |
      |  Holden  | Caulfield |  1 Fake St|
      |  Phoebe  | Caulfield |  1 Fake St|
      |  Winston |   Smith   | 3 First St|
      |  Hiro    |Protagonist|1 Second St|
    When I fill in "search" with "3 First St"
    And I press "Search"
    Then I should be on the clients page
    And I should see the following clients:
      | Last Name |First Name|
      | Smith     | Winston  |
    And the "search" field should contain "3 First St"

#  Scenario: Search for phone number
#    Given I am on the clients page
#    And I am an employee
#    And the following clients:
#      |first_name| last_name | phone |
#      |  Holden  | Caulfield |555-555-5555|
#      |  Phoebe  | Caulfield |123-456-7890|
#      |  Winston |   Smith   |222-123-4323|
#      |  Hiro    |Protagonist|234-127-1483|
#    When I fill in "search" with "234-127-1483"
#    And I press "Search"
#    Then I should be on the clients page
#    And I should see the following clients:
#      | Last Name  |First Name|
#      | Protagonist| Hiro     |

  Scenario: Search for e-mail address
    Given I am on the clients page
    And I am an employee
    And the following clients:
      |first_name| last_name | email                       |
      |  Holden  | Caulfield |holden.caulfield@dinocore.net|
      |  Phoebe  | Caulfield |phoebe.caulfield@dinocore.net|
      |  Winston |   Smith   |winston.smith@dinocore.net   |
      |  Hiro    |Protagonist|hiro.protagonist@dinocore.net|
    When I fill in "search" with "phoebe.caulfield@dinocore.net"
    And I press "Search"
    Then I should be on the clients page
    And I should see the following clients:
      | Last Name  |First Name|
      | Caulfield  | Phoebe   |
    And the "search" field should contain "phoebe.caulfield@dinocore.net"

