When /^I save a new case$/ do
  When "I follow \"Save Case As\""
  When "I fill in \"case[name]\" with \"Case Name\""
  When "I press \"Save\""
end

Then /^My answers should be saved$/ do
  @user.cases.first.current_situation.answers.length.should == 2
end

Given /^I have saved my answers as a new case$/ do
  When "I save a new case"
end

When /^I retrieve my saved case$/ do
  When "I follow \"Open a Case\""
  When "I follow \"Open Case\""
end

When /^I save the case again$/ do
  When "I follow \"Save Case\""
  Then "I should see a JS alert"
  # selenium.chooseOkOnNextConfirmation();
end

Then /^My new answers should be saved$/ do
  @user.cases.first.current_situation.answers.length.should == 2
end

Then /^I should see my answers$/ do
  Then "I should see the first question of the first group"
  Then "I should see the second question of the first group"
end

Then /^I should see a JS alert$/ do
    pending # selenium.is_alert_present.should be_true
end