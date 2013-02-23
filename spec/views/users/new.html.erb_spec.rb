require 'spec_helper'
require 'users_helper.rb'

describe "/users/new.html.erb" do
  include UsersHelper
  before(:each) do
    assign(:user, User.new)
  end
  it "includes a notice that the user can change their information" do
    render
    rendered.should =~ /#{Regexp.quote("you can change your information")}/
  end

  

  it "includes a privacy notice" do
    render
    rendered.should =~ /#{Regexp.quote("Your information will not be shared")}/
  end

  it "has a field for entering your benefits counselor" do
    render
    assert_select "input#user_counselor_name" do
      assert_select "[name=?]", "user[counselor_name]"
    end
  end

  it "has mandatory fields for login, email, and both passwords; but not for counselor_name" do
    render
    assert_select "input#user_login + span[class='red']"
    assert_select "input#user_email + span[class='red']"
    assert_select "input#user_password + span[class='red']"
    assert_select "input#user_password_confirmation + span[class='red']"
    assert_select "input#user_counselor_name + span[class='red']", false
  end
  
  it "has checkboxes for allowing sharing, receving sharing, and receiving notifications" do
    render
    assert_select "input#user_allow_fileshare" do
      assert_select "[type='checkbox']"
    end
    assert_select "input#user_receive_fileshare" do
      assert_select "[type='checkbox']"
    end

    assert_select "input#user_receive_share_email" do
      assert_select "[type='checkbox']"
    end

  end
  it "has help links next to each of the file related labels" do
    render
    assert_select "legend a[class='help']"
   # assert_select "label[for='user_allow_fileshare'] + a[class='help']"
   # assert_select "label[for='user_receive_share_email'] + a[class='help']"
   # assert_select "label[for='user_receive_fileshare'] + a[class='help']"
  end
    
end
