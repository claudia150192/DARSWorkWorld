require 'spec_helper'

describe "/question_groups/index.html.erb" do
  include QuestionGroupsHelper

  before(:each) do
    assign(:question_groups, [
      stub_model(QuestionGroup,
        :name => "value for name"
      ),
      stub_model(QuestionGroup,
        :name => "value for name"
      )
    ])
  end

  it "renders a list of question_groups" do
    render
    assert_select("tr>td", "value for name".to_s, "2")
  end
end
