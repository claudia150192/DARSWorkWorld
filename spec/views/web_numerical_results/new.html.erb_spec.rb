require 'spec_helper'

describe "/web_numerical_results/new.html.erb" do
  include WebNumericalResultsHelper

  before(:each) do
    assign(:web_numerical_result, WebNumericalResult.new)
  end
  it "renders new web_numerical_result form" do
    render

    assert_select "form#new_web_numerical_result" do
      assert_select "[action=?]", web_numerical_results_path
      assert_select "[method=post]"
      assert_select "input#web_numerical_result_name" do
        assert_select "[name=?]", "web_numerical_result[name]"
      end
      assert_select "textarea#web_numerical_result_display_rules" do
        assert_select "[name=?]", "web_numerical_result[display_rules]"
      end
      assert_select "select#web_numerical_result_order" do
        assert_select "[name=?]", "web_numerical_result[order]"
      end
      assert_select "select#web_numerical_result_web_calc_id" do
        assert_select "[name=?]", "web_numerical_result[web_calc_id]"
      end
      assert_select "select#web_numerical_result_group_id" do
        assert_select "[name=?]", "web_numerical_result[group_id]"
      end
    end
  end
end
