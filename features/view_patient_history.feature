Feature: View Patient History
  In order to safely treat patients
  An employee
  needs to be able to view a patient's medical history

  Scenario: View all patient history
    Given I have added a client and patient
    And I have made a diagnosis
    When I go to the patient events page
    Then I should see a list of events

  Scenario: Filter patient history by event type
    Given I have added a client and patient
    And I have made a diagnosis named "Boneitis"
    And I am on the patient events page
    When I uncheck "Diagnoses"
    And I press "Filter"
    Then I should not see "Boneitis"
