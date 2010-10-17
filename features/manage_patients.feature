Feature: Manage patients
  In order to keep track of patients
  An employee
  wants to be able to add, edit, and delete patients

  Scenario: Go to new patient page
    Given I have added a client
    And I am editing the client
    And I am an employee
    When I follow "New Patient"
    Then I should be on the new patient page
    And I should see the edit client form
    And I should see the new patient form

  Scenario: Add a new patient
    Given I have added a client
    And I am on the new patient page
    And I am an employee
    When I fill in "Name" with "Moose"
    And I press "Create Patient"
    Then I should be on the patients page
    And I should see "Patient created successfully"
