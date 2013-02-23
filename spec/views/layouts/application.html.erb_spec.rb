require 'spec_helper'

describe "/layouts/application.html.erb" do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
    @user = Factory(:user)
    assign(:user,@user)
  end
  it "renders with the lang attribute set" do
    render
    assert_select "html[lang='en-US']"
  end
end

def current_user
  @user
end

def logged_in?
  false
end
