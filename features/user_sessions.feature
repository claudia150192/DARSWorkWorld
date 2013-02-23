Feature: User Sessions

  In order to create a scenario
  As a registered user
  I want to log in and log out

  Scenario: log in
    Given I am a registered user
    And I am on the homepage
    When I login
    Then I should see "Welcome"
    And I should not see "Log In"
    And I should see "Logout"

  Scenario: log out
    Given I am logged in
    And I am on the homepage
    When I follow "Logout"
    Then I should see "Logout successful!"
    And I should see "Register"
    And I should see "Log In"
