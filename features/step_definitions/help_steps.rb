Given /^I have no JavaScript$/ do
end

When /^I follow the help link$/ do
  click_link("Help")
end

Then /^I should see help about file sharing options$/ do
  # not sure what to test here yet; might save it for the view or controller test
end

