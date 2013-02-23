require 'spec_helper'

describe "/question_groups/edit.html.erb" do
  include QuestionGroupsHelper

  before(:each) do
    @question_group = stub_model(QuestionGroup,
      :new_record? => false,
      :name => "value for name"
    )
    assign(:question_group, @question_group)
  end

  it "renders the edit question_group form" do
    render

    assert_select("form.edit_question_group") do
      assert_select "[action=?]", question_group_path(@question_group)
      assert_select "[method=post]"
      assert_select('input#question_group_name') do
        assert_select '[name=?]', "question_group[name]"
      end
    end
  end
end
