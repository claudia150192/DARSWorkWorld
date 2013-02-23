require 'spec_helper'

describe "/question_groups/new.html.erb" do
  include QuestionGroupsHelper

  before(:each) do
    assign(:question_group, QuestionGroup.new)
  end

  it "renders new question_group form" do
    render

    assert_select("form#new_question_group") do
      assert_select "[action=?]", question_groups_path
      assert_select "[method=post]"
      assert_select("input#question_group_name") do
        assert_select "[name=?]", "question_group[name]"
      end
    end
  end
end
