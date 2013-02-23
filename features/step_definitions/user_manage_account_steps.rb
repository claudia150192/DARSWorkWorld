Given /^I am a logged in user$/ do
  login
end

When /^I update my account$/ do
  click_link "Edit"
  fill_in "Login", :with => "johnny" 
  click_button "Update"
end
