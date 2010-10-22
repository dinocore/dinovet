Feature: Manage diagnoses
  In order to maintain a standard list of diagnoses
  An employee
  wants to be able to add, edit, and delete diagnoses

  Scenario: View a list of all diagnosis
    Given the following diagnoses:
      | code |   name   |     description     |
      | 1234 |  Rabies  |  A viral infection  |
      | 1235 | Boneitis | A fictional disease |
    And I am an employee
    When I go to the diagnoses page
    Then I should see the following diagnoses:
      | Code |  Name  |    Description    |
      | 1234 | Rabies | A viral infection |
      | 1235 | Boneitis | A fictional disease |
    

  Scenario: Add a new diagnosis
    Given I am on the new diagnosis page
    And I am an employee
    When I fill in "Name" with "Rabies"
    And I fill in "Code" with "ZR8182"
    And I fill in "Description" with "A viral disease that causes acute encephalitis in warm-blooded animals."
    And I press "Create Diagnosis"
    Then I should be on the diagnoses page
    And I should see "Diagnosis created successfully"
