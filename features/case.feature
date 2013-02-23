Feature: Case

  In order to retrieve my answers and continue working on my situation at a later time
  As a registered user
  I want to save my situation

  Scenario: Save new case
    Given I have started a new situation in group mode
    When I save a new case
    Then My answers should be saved
    
  Scenario: Override saved case
    Given I have started a new situation in group mode
    And I have saved my answers as a new case
    When I retrieve my saved case
    And I save the case again
    Then My new answers should be saved
    
  Scenario: Open saved case
    Given I have started a new situation in group mode
    And I have saved my answers as a new case
    When I retrieve my saved case
    Then I should see my answers
