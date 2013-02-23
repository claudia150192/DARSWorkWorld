require 'spec_helper'

describe "/questions/show.html.erb" do
  include QuestionsHelper
  before(:each) do
    QuestionGroup.destroy_all
    @user = Factory(:user)
    @group = Factory(:question_group)
    assign(:question, Factory(:question, :group => @group))
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~(/question/)
    rendered.should =~(/answer\ me/)
    rendered.should =~(/always/)
    rendered.should =~(/answer/)
    rendered.should =~(/1/)
  end
end

def current_user
  @user
end
