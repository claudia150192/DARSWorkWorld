Feature: Question Group Administration

  In order to manage question groups
  As an admin user
  I want to create and edit question groups

  Scenario: create
    Given I am an admin user
    And I am on the question_groups page
    When I create a new question group
    Then I should see "Successfully created question group."

  Scenario: edit
    Given I am an admin user
    And I am on the question_groups page
    When I edit a question group
    Then I should see "Question group updated."

  Scenario: destroy
    Given I am an admin user
    And I am on the question_groups page
    When I delete a question group
    Then I should see "Question group deleted."