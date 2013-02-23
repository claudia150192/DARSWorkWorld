def question_group
  @question_group ||= Factory(:question_group)
end

When /^I create a new question group$/ do
  click_link "New question group"
  fill_in "Name", :with => "test group"
  fill_in "question_group[workbook_order]", :with=> 1
  click_button "Create"
end

When /^I edit a question group$/ do
  question_group
  visit question_group_path(question_group)
  click_link "Edit"
  fill_in "Name", :with => "Test Group"
  click_button "Update"
end

When /^I delete a question group$/ do
  pending
  question_group
  click_link "Destroy"
  click_button "OK"
end
