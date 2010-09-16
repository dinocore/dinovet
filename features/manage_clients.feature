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
    Then I should see ""
    And I should see "last_name 1"

  Scenario: Delete client
    Given the following clients:
      |first_name|last_name|
      |first_name 1|last_name 1|
      |first_name 2|last_name 2|
      |first_name 3|last_name 3|
      |first_name 4|last_name 4|
    When I delete the 3rd client
    Then I should see the following clients:
      |First name|Last name|
      |first_name 1|last_name 1|
      |first_name 2|last_name 2|
      |first_name 4|last_name 4|
