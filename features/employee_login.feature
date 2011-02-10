Feature: Employee Login
  In order to keep information secure
  An employee
  needs to be able to login to the site

  Scenario: Employee successfully logs in
    Given I am on the login page
    When I fill in "Username" with "holden"
    And I fill in "Password" with "holdenpass"
    And I press "Login"
    Then I should be on the home page
    And I should see "Successfully logged in"

  Scenario: Employee logs out
    Given I am logged in
    And I press "Log out"
    Then I should be on the login page
    And I should see "Log out successful"

  Scenario: Employee uses wrong credentials
    Given I am on the login page
    When I fill in "Username" with "holdenzs"
    And I fill in "Password" with "wrongpass"
    And I press "Login"
    Then I should be on the login page
    And I should see "Incorrect login or password."
