def question
  @question ||= Factory(:question, :group => question_group)
end


When /^I create a new question$/ do
  question_group
  click_link "New question"
  fill_in "Name", :with => "test question"
  fill_in "Text", :with => "please answer this question"
  fill_in "question[display_rules]", :with => "always"
  fill_in "question[default_answer]", :with => "answer"
  fill_in "Reference", :with => "1"
  select('select', :from => 'question[question_type]')
  select "1", :from => "question[question_order]"
  select @question_group.name, :from => "Group"
  fill_in "question[workbook_order]", :with =>1
  click_button "Create"
end

When /^I edit a question$/ do
  question
  visit question_path(question)
  click_link "Edit"
  fill_in "Name", :with => "Test Question"
  click_button "Update"
end

When /^I delete a question$/ do
  pending
  question
  click_link "Destroy"
  click_button "OK"
end
