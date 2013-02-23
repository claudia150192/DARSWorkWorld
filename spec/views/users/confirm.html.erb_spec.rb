require 'spec_helper'

describe "/users/confirm.html.erb" do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
    @user = Factory(:user)
    assign(:user,@user)
  end
  describe "user is authorized to delete this user" do
    before(:each) do
      @ability.can :manage, User
    end

    it "should have a form to post the delete request" do
      render
      assert_select "form[method='post']" do
        assert_select "[action=?]", user_path(@user)
      end
    end

    it "should have a button that says 'delete'" do
      render
      assert_select "form[method='post'][action=?]", user_path(@user) do
        assert_select "input[type='submit'][value=?]", "Delete"
      end
    end
  end
end
