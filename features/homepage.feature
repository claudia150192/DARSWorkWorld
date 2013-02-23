Feature: Homepage
  Scenario: Anonymous User Visiting
    When I go to the homepage
    Then I should see "Log In"
    And I should see "Register"
