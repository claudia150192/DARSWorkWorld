require 'spec_helper'

describe "/web_numerical_results_groups/new.html.erb" do
  include WebNumericalResultsGroupsHelper

  before(:each) do
    assign(:web_numerical_results_group, WebNumericalResultsGroup.new)
  end

  it "renders new web_numerical_results_group form" do
    render
    assert_select("form#new_web_numerical_results_group") do
      assert_select "[action=?]", web_numerical_results_groups_path
      assert_select "[method=post]"
    end
    
    assert_select "input#web_numerical_results_group_name" do
      assert_select "[name=?]", "web_numerical_results_group[name]"
    end
    assert_select "select#web_numerical_results_group_order" do
      assert_select "[name=?]", "web_numerical_results_group[order]"
    end
  end
end
