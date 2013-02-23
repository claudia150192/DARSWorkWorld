Feature: Question Administration

  In order to manage questions
  As an admin user
  I want to create and edit questions

  Scenario: create
    Given I am an admin user
    And I am on the questions page
    When I create a new question
    Then I should see "Successfully created question."

  Scenario: edit
    Given I am an admin user
    And I am on the questions page
    When I edit a question
    Then I should see "Question updated."

  Scenario: destroy
    Given I am an admin user
    And I am on the questions page
    When I delete a question
    Then I should see "Question deleted."
