require 'spec_helper'

describe "/question_groups/show.html.erb" do
  include QuestionGroupsHelper
  before(:each) do
    assign(:question_group, stub_model(QuestionGroup,
      :name => "value for name"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~(/value\ for\ name/)
  end
end

def current_user
  Factory(:user)
end
