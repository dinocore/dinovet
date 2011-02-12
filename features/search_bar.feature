Feature: Search bar
  In order to quickly find clients and patients
  An employee
  wants to be able to search for clients by name, address, and phone number and
  patient by name, species, and breed
  
  @search
  Scenario: Search for client's last name
    Given I am on the search page
    And I am an employee
    And the following clients:
      |first_name| last_name |
      |  Holden  | Caulfield |
      |  Phoebe  | Caulfield |
      |  Winston |   Smith   |
      |  Hiro    |Protagonist|
    And all models have been indexed
    When I fill in "search" with "Caulfield"
    And I press "Search"
    Then I should be on the search page
    And the "search" field should contain "Caulfield"
    And I should see "Caulfield, Holden"
    And I should see "Caulfield, Phoebe"

  @search
  Scenario: Search for client's first name
    Given I am on the search page
    And I am an employee
    And the following clients:
      |first_name| last_name |
      |  Holden  | Caulfield |
      |  Phoebe  | Caulfield |
      |  Winston |   Smith   |
      |  Hiro    |Protagonist|
    And all models have been indexed
    When I fill in "search" with "Holden"
    And I press "Search"
    Then I should be on the search page
    And I should see "Caulfield, Holden"
    And the "search" field should contain "Holden"

  @search
  Scenario: Search for client's address
    Given I am on the search page
    And I am an employee
    And the following clients:
      |first_name| last_name | address_1 |
      |  Holden  | Caulfield |  1 Fake St|
      |  Phoebe  | Caulfield |  1 Fake St|
      |  Winston |   Smith   | 3 First St|
      |  Hiro    |Protagonist|1 Second St|
    And all models have been indexed
    When I fill in "search" with "3 First St"
    And I press "Search"
    Then I should be on the search page
    And I should see "Smith, Winston"
    And the "search" field should contain "3 First St"

  @search
  Scenario: Search for client's phone number
    Given I am on the search page
    And I am an employee
    And the following clients:
      |first_name| last_name |phone_numbers.number|
      |  Holden  | Caulfield |555-555-5555| 
      |  Phoebe  | Caulfield |123-456-7890| 
      |  Winston |   Smith   |222-123-4323| 
      |  Hiro    |Protagonist|234-127-1483| 
    And all models have been indexed
    When I fill in "search" with "234-127-1483"
    And I press "Search"
    Then I should be on the search page
    And I should see "Protagonist, Hiro"
    And the "search" field should contain "234-127-1483"

  @search
  Scenario: Search for client's e-mail address
    Given I am on the search page
    And I am an employee
    And the following clients:
      |first_name| last_name | email                       |
      |  Holden  | Caulfield |holden.caulfield@dinocore.net|
      |  Phoebe  | Caulfield |phoebe.caulfield@dinocore.net|
      |  Winston |   Smith   |winston.smith@dinocore.net   |
      |  Hiro    |Protagonist|hiro.protagonist@dinocore.net|
    And all models have been indexed
    When I fill in "search" with "phoebe.caulfield@dinocore.net"
    And I press "Search"
    Then I should be on the search page
    And I should see "Caulfield, Phoebe"
    And the "search" field should contain "phoebe.caulfield@dinocore.net"
