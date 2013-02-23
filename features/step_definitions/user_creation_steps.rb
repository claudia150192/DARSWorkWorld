def register
  visit path_to("the homepage")
  click_link "Register"
  fill_in "Login", :with => "john"
  fill_in "Email", :with => "john@example.com"
  fill_in "Password", :with => "funkypass"
  fill_in "Password confirmation", :with => "funkypass"
  click_button "Register"
end

Given /^I am a guest user$/ do
end

When /^I register a new account$/ do
  register
end

Then /^I should be registered$/ do
  @user = User.find_by_login("john");
  @user.should be_an_instance_of(User)
end

Then /^I should not be active$/ do
  @user.active.should be_false
end

