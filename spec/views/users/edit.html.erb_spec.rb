require 'spec_helper'

describe "/users/edit.html.erb" do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
    @user = Factory(:user)
    assign(:user,@user)
  end

  it "should have a link to delete the user" do
    @ability.can :manage, User
    render
    assert_select "a[href=?]", user_confirm_path(@user)
  end
end

def current_user
  @user
end

