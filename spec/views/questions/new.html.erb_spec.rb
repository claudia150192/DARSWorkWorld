require 'spec_helper'

describe "/questions/new.html.erb" do
  include QuestionsHelper

  before(:each) do
    assign(:question, Question.new)
  end

  it "renders new question form" do
    render

    assert_select("form#new_question") do
      assert_select "[action=?]", questions_path
      assert_select "[method=post]"
      assert_select("input#question_name") do
        assert_select "[name=?]", "question[name]"
      end
      assert_select("input#question_text") do
        assert_select "[name=?]", "question[text]"
      end
      assert_select("textarea#question_display_rules") do
        assert_select "[name=?]", "question[display_rules]"
      end
      assert_select("textarea#question_default_answer") do
        assert_select "[name=?]", "question[default_answer]"
      end
      assert_select("input#question_reference_id") do
        assert_select "[name=?]", "question[reference_id]"
      end
    end
  end
end
