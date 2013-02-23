Feature: User Administration

  In order to manage users
  As an admin user
  I want to create and edit users

  Scenario: create
    Given I am an admin user
    And I am on the users page
    When I create a new user
    Then I should see "Please have the user check email for activation instructions!"

  Scenario: edit
    Given I am an admin user
    And I am on the users page
    When I edit a user
    Then I should see "Account updated!"

  Scenario: destroy
    Given I am an admin user
    And I am on the users page
    When I delete a user
    Then I should see "User deleted!"
