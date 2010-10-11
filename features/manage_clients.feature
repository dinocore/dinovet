Feature: Manage clients
  In order to keep track of clients
  An employee
  wants to be able to add, edit, and delete clients
  
  Scenario: Add a new client
    Given I am on the new client page
    And I am an employee
    When I fill in "First name" with "Holden"
    And I fill in "Last name" with "Caulfield"
    And I fill in "Address 1" with "1234 1st Street"
    And I fill in "Address 2" with "Apt. 23"
    And I fill in "City" with "New York"
    And I select "New York" from "State"
    And I fill in "Zipcode" with "10001"
    And I select "Home" from "client_phone_numbers_0_type" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_country_code" with "1" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_area_code" with "555" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_prefix" with "555" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_suffix" with "5555" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_extension" with "55" within "#phone-number-0"
    And I fill in "E-mail" with "holden@dinocore.net"
    And I press "Create Client"
    Then I should be on the clients page
    And I should see "Client added successfully"

  Scenario: View a list of all clients
    Given I am an employee
    And I have added a client named "Holden"
    And I am on the clients page
    Then I should see "Holden"

  Scenario: Edit an existing client
    Given I am an employee
    And I have added a client named "Holden"
    And I am editing the client
    When I fill in "First name" with "Phoebe"
    And I press "Update Client"
    Then I should be on Phoebe's page
    And I should see "Phoebe"

  Scenario Outline: Invalid client data entered
    Given I am on the new client page
    And I am an employee
    When I fill in "First name" with "<first_name>"
    And I fill in "Last name" with "<last_name>"
    And I fill in "Address 1" with "<address_1>"
    And I fill in "City" with "<city>"
    And I select "<state>" from "State"
    And I fill in "Zipcode" with "<zipcode>"
    And I fill in "client_phone_numbers_0_area_code" with "<phone_area_code>" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_prefix" with "<phone_prefix>" within "#phone-number-0"
    And I fill in "client_phone_numbers_0_suffix" with "<phone_suffix>" within "#phone-number-0"
    And I fill in "E-mail" with "<email>"
    And I press "Create Client"
    Then I should be on the clients page
    And I should see "Failed to create client"

  Examples:
    |first_name|last_name|address_1|  city  |  state |zipcode|       email       | phone_area_code | phone_prefix | phone_suffix |
    |          |Caulfield|1 Fake St|New York|New York| 10001 |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |         |1 Fake St|New York|New York| 10001 |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |Caulfield|         |New York|New York| 10001 |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|        |New York| 10001 |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|        | 10001 |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|New York|       |holden@dinocore.net|       222       |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |       fail        |       222       |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |holden@dinocore.net|                 |     333      |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |holden@dinocore.net|       222       |              |     4444     |
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |holden@dinocore.net|       222       |     333      |              |
