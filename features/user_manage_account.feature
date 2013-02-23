Feature: Update User Information

  In order to keep my information up to date
  As a logged in user
  I want to update my account information

  Scenario: update information
    Given I am a logged in user
    And I am on the account page for "john"
    When I update my account
    Then I should see "Account updated!"

