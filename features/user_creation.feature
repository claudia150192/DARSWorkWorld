Feature: Register User

  In order to log in to the application
  As a guest user
  I want to register a new account

  Scenario: register
    Given I am a guest user
    And I am on the homepage
    When I register a new account
    Then I should be registered
    But I should not be active
    And I should be on "the registration confirmation page"
    And I should see "Please check your email for activation instructions!"
