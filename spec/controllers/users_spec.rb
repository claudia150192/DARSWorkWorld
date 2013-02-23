require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = Factory(:user)
  end

  describe "GET /user/confirm/:id" do
    before(:each) do
      get :confirm, :id=>@user.id
    end

    it "should render the destroy confirmation page" do
      response.should render_template
    end

    it "should send the link to the target" do
      assigns[:user].should eq(@user)
    end
  end

  describe "DELETE /user/:id" do
    it "be able to destroy a user" do
      user = mock_model(User)
      User.stub(:find_by_id).and_return(user)
      user.should_receive(:destroy)
      post :destroy
    end
  end
end
