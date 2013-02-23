require 'ruby-debug'

def admin
  @admin_attr = Factory.attributes_for(:admin)
  @admin ||= User.find_by_login "admin"
  @admin ||= User.create!(@admin_attr)
  @admin.admin = true
  @admin.activate!
end

def admin_login
  admin
  visit login_path
  fill_in "Login", :with => "admin" 
  fill_in "Password", :with => "funkypass"
  click_button "Login"
end

Given /^I am an admin user$/ do
  admin_login
end

When /^I create a new user$/ do
  click_link "New user"
  fill_in "Login", :with => "john"
  fill_in "Email", :with => "john@example.com"
  fill_in "Password", :with => "funkypass"
  fill_in "Password confirmation", :with => "funkypass"
  click_button "Register"
end

When /^I edit a user$/ do
  user
  click_link "Edit"
  fill_in "Login", :with => "johnny"
  click_button "Update"
end

When /^I delete a user$/ do
  pending
  user
  click_link "Destroy"
  click_button "OK"
end
