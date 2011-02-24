Feature: Make treatment plan
  In order to outline a patient's treatment
  An employee
  wants to be able to create a list of treatments to be administered

  Scenario: View the new treatment plan page
    Given I have added a client and patient
    And I am an employee
    When I go to the new treatment plan page
    Then I should see "Treatment Plan" within "#treatment-plan"

  @javascript
  Scenario: Move a treatment from the treatment list to the treatment plan
    Given I have added a client and patient
    And I have created a treatment named "Drugs"
    And I have created a treatment named "The cure"
    And I am an employee
    And I am on the new treatment plan page
    When I follow "Drugs" within "treatement_category_list"
    And I press "Add"
    Then I should see "Drugs" within "treatment_plan_treatments"
    And I should see "Drugs" within "treatment_category_list"
    And I should not see "The cure" within "treatment_plan_treatments"

  @javascript
  Scenario: Display comment field after adding a treatment
    Given I have added a client and patient
    And I have created a treatment named "Drugs"
    And I have created a treatment named "The cure"
    And I am an employee
    And I am on the new treatment plan page
    When I follow "Drugs" within "treatement_category_list"
    And I press "Add"
    Then I should see "treatment_plan_comment"

  @javascript
  Scenario: Create a new treatment plan
    Given I have added a client and patient
    And I have created a treatment named "Drugs"
    And I have created a treatment named "The cure"
    And I am an employee
    And I am on the new treatment plan page
    When I follow "Drugs" within "treatement_category_list"
    And I press "Add"
    And I fill in "treatment_plan_comment" with "I hope this works."
    And I press "Create Treatment plan"
    Then I should see "Treatment Plans"
    And I should see "Treatment plan created successfully"
