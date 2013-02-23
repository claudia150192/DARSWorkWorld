# used for debugging: 
# puts "Response Body:"
# puts response.body

def setup_scenario
  @first_group ||= Factory(:first_group)
  @second_group ||= Factory(:second_group)
  @first_group.next_group = @second_group
  @first_question ||= Factory(:first_question, :group => @first_group)
  @second_question ||= Factory(:second_question, :group => @first_group)
  @third_question ||= Factory(:third_question, :group => @second_group)
  @fourth_question ||= Factory(:fourth_question, :group => @second_group)
  @first_group.save
  @second_group.save
  user
  login
end

def setup_income_and_expense_questions
  @income_group ||= Factory(:income_group)
  @expense_group ||= Factory(:expense_group)
  @second_group.next_group = @income_group
  @income_group.next_group = @expense_group
  @income_question ||= Factory(:income_question, :group => @income_group)
  @expense_question ||= Factory(:expense_question, :group => @expense_group)
  @second_group.save
  @income_group.save
  @expense_group.save
  @income_answer = 500.00
end

Then /^the "([^"]*)" named field should contain "([^"]*)"$/ do |field, value|
  field_value = find_field(field).value
  if field_value.respond_to? :should
    field_value.should =~ /#{value}/
  else
    assert_match(/#{value}/, field_value)
  end
end

When /^I start a new situation in one_at_a_time mode$/ do
  setup_scenario
  visit "/situations/new?mode=one_at_a_time"
end

Then /^I should see the first question of the first group$/ do
  Then "the \"groups[#{@first_question.group.name}][questions][#{@first_question.name}]\" named field should contain \"#{@first_question.default_answer}\""
end

Then /^I should not see the second question of the first group$/ do
  #lambda { field_named("groups[#{@second_question.group.name}][questions][#{@second_question.name}]") }.should raise_error(
   # Webrat::NotFoundError, "Could not find field named \"groups[first_group][questions][second_question]\""
  page.should have_no_content("groups[#{@second_question.group.name}][questions][#{@second_question.name}]")
  
end

Given /^I am satisfied with the answer of the first question in the group$/ do
  When "I start a new situation in one_at_a_time mode"
  Then "I should see the first question of the first group"
end

When /^I (click on|have clicked) the (continue|accept) button$/ do |action, button|
  click_button button.titleize
end


Then /^I should see the second question of the first group$/ do
  Then "the \"groups[#{@second_question.group.name}][questions][#{@second_question.name}]\" named field should contain \"#{@second_question.default_answer}\""
end

Given /^I have started a new situation in one_at_a_time mode$/ do
  When "I start a new situation in one_at_a_time mode"
  Then "I should see the first question of the first group"
end

Given /^I have answered all the questions in the first group$/ do
  When "I click on the accept button"
  Then "I should see the second question of the first group"
  When "I click on the accept button"
end

Given /^I have answered all the questions in the second group$/ do
  When "I click on the accept button"
  Then "I should see the second question of the second group"
  When "I click on the accept button"
end

Then /^I should see the first question of the second group$/ do
  Then "the \"groups[#{@third_question.group.name}][questions][#{@third_question.name}]\" named field should contain \"#{@third_question.default_answer}\""
end

Then /^I should not see the second question of the second group$/ do
  lambda { field_named("groups[#{@fourth_question.group.name}][questions][#{@fourth_question.name}]") }.should raise_error(
    Webrat::NotFoundError, "Could not find field named \"groups[#{@fourth_question.group.name}][questions][#{@fourth_question.name}]\""
  )
end

When /^I start a new situation in group mode$/ do
  setup_scenario
  visit "/situations/new?mode=group"
end

Given /^I have started a new situation in group mode$/ do
  When "I start a new situation in group mode"
  Then "I should see the first question of the first group"
  Then "I should see the second question of the first group"
end

Given /^I have gone through the first two groups$/ do
  When "I click on the continue button"
  When "I click on the continue button"
end

Then /^I should see the second question of the second group$/ do
  Then "the \"groups[#{@fourth_question.group.name}][questions][#{@fourth_question.name}]\" named field should contain \"#{@fourth_question.default_answer}\""
end

Given /^I am answering expense questions$/ do
  setup_income_and_expense_questions
end

Given /^I have answered all the income questions$/ do
  When "I fill in \"groups[#{@income_group.name}][questions][#{@income_question.name}]\" with \"#{@income_answer}\""
end

Then /^I should see my previous answer as the default answer$/ do
  Then "the \"groups[#{@expense_group.name}][questions][#{@expense_question.name}]\" named field should contain \"#{@income_answer}\""
end
