def user
  @user_attr = Factory.attributes_for(:user)
  @user ||= User.find_by_login("john")
  @user ||= User.create!(@user_attr)
  @user.activate!
end

def login
  user
  visit root_path
  click_link "Log In"
  fill_in "Login", :with => "john" 
  fill_in "Password", :with => "funkypass"
  click_button "Login"
end

Given /^I am a registered user$/ do
  user
end

When /^I login$/ do
  click_link "Log In"
  user
  fill_in "Login", :with=> "john"
  fill_in "Password", :with=> "funkypass"
  click_button "Login"
end


Given /^I am logged in$/ do
  login
end
