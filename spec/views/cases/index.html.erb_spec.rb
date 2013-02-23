require 'spec_helper'

describe "/cases/index.html.erb" do
  include CasesHelper

  before(:each) do
    @user = Factory(:user)
    assign(:cases, [
      stub_model(Case,
        :user_id => @user.id,
        :name => "value for name"
      ),
      stub_model(Case,
        :user_id => @user.id,
        :name => "another value for name"
      )
    ])
  end

  it "renders a list of cases" do
    render
    assert_select("tr>td", @user.login.to_s, "2")
    assert_select("tr>td", "value for name".to_s, "1")
    assert_select("tr>td", "another value for name".to_s, "1")
  end
end
