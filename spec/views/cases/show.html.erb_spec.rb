require 'spec_helper'

describe "/cases/show.html.erb" do
  include CasesHelper
  before(:each) do
    @user = Factory(:user)
    assign(:case, stub_model(Case,
      :user_id => @user.id,
      :name => "value for name"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~/john/
    rendered.should =~/value\ for\ name/
  end
end

def current_user
  @user
end
