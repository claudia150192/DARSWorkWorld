Feature: Situation

  In order to check my eligibility 
  As a registered user
  I want to create a new situation

  Scenario: New situation in one-at-a-time mode
    When I start a new situation in one_at_a_time mode
    Then I should see the first question of the first group
    And I should not see the second question of the first group

  Scenario: Next question in one-at-a-time mode
    Given I am satisfied with the answer of the first question in the group
    When I click on the accept button
    Then I should see the second question of the first group
    
  Scenario: Next group in one-at-a-time mode
    Given I have started a new situation in one_at_a_time mode
    And I have answered all the questions in the first group
    When I click on the continue button
    Then I should see the first question of the second group
    And I should not see the second question of the second group
    
  Scenario: New situation in group mode
    When I start a new situation in group mode
    Then I should see the first question of the first group
    And I should see the second question of the first group

  Scenario: Next group in group mode
    Given I have started a new situation in group mode
    And I have answered all the questions in the first group
    When I click on the continue button
    Then I should see the first question of the second group
    And I should see the second question of the second group
    
  Scenario: Default answers that are calculated based on answers to previous questions and that have been viewed but not been accepted should be recalculated
    Given I have started a new situation in group mode
    And I am answering expense questions
    And I have gone through the first two groups
    And I have answered all the income questions
    When I click on the continue button
    Then I should see my previous answer as the default answer
