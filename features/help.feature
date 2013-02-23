Feature: Getting Help

  In order to be able to understand how to use the application
  as a user
  I want to be able to view common help topics

  Scenario: Getting help on file sharing options when registering
    Given I am on the new user page
    And I have no JavaScript
    When I follow the help link
    Then I am on the help page for "filesharing"
    And I should see help about file sharing options
