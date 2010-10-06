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
    And I fill in "Phone" with "555-555-5555"
    And I fill in "E-mail" with "holden@dinocore.net"
    And I press "Add Client"
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
    And I press "Save Client"
    Then I should be on Phoebe's page
    And I should see "Phoebe"

  Scenario Outline: Invalid client data entered
    Given I am on the new client page
    And  I am an employee
    When I fill in "First name" with "<first_name>"
    And I fill in "Last name" with "<last_name>"
    And I fill in "Address 1" with "<address_1>"
    And I fill in "Address 2" with "<address_2>"
    And I fill in "City" with "<city>"
    And I select "<state>" from "State"
    And I fill in "Zipcode" with "<zipcode>"
    And I fill in "Phone" with "<phone>"
    And I fill in "E-mail" with "<email>"
    And I press "Add Client"
    Then I should be on the clients page
    And I should see "Failed to create client"

  Examples:
    |first_name|last_name|address_1|  city  |  state |zipcode|     phone    |       email       |
    |          |Caulfield|1 Fake St|New York|New York| 10001 |(555) 555-1234|holden@dinocore.net|
    |  Holden  |         |1 Fake St|New York|New York| 10001 |(555) 555-1234|holden@dinocore.net|
    |  Holden  |Caulfield|         |New York|New York| 10001 |(555) 555-1234|holden@dinocore.net|
    |  Holden  |Caulfield|1 Fake St|        |New York| 10001 |(555) 555-1234|holden@dinocore.net|
    |  Holden  |Caulfield|1 Fake St|New York|        | 10001 |(555) 555-1234|holden@dinocore.net|
    |  Holden  |Caulfield|1 Fake St|New York|New York|       |(555) 555-1234|holden@dinocore.net|
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |              |holden@dinocore.net|
    |  Holden  |Caulfield|1 Fake St|New York|New York| 10001 |(555) 555-1234|       fail        |
