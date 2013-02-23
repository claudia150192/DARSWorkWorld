require 'spec_helper'

describe "/questions/index.html.erb" do
  include QuestionsHelper

  before(:each) do
    QuestionGroup.destroy_all
    @group = Factory(:question_group)
    assign(:questions,
           [Factory(:question, :group => @group), 
            Factory(:question, :group => @group, :name => "another name")])
  end

  it "renders a list of questions" do
    render
    assert_select("tr>td", "question".to_s, "1")
    assert_select("tr>td", "another name".to_s, "1")
    assert_select("tr>td", "answer me".to_s, "2")
    assert_select("tr>td", "always".to_s, "2")
    assert_select("tr>td", "answer".to_s, "2")
    assert_select("tr>td", "1".to_s, "2")
  end
end
