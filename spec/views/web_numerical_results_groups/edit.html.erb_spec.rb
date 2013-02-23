require 'spec_helper'

describe "/web_numerical_results_groups/edit.html.erb" do
  include WebNumericalResultsGroupsHelper

  before(:each) do
    @web_numerical_results_group = stub_model(WebNumericalResultsGroup,
      :new_record? => false,
      :name => "value for name",
      :order => 1
    )
    assign(:web_numerical_results_group, @web_numerical_results_group)
  end

  it "renders the edit web_numerical_results_group form" do
    render
    assert_select "form.edit_web_numerical_results_group" do
      assert_select "[action=?]", web_numerical_results_group_path(@web_numerical_results_group)
      assert_select "[method=post]"
      assert_select "input#web_numerical_results_group_name" do
        assert_select "[name=?]", "web_numerical_results_group[name]"
      end
      assert_select 'select#web_numerical_results_group_order' do
        assert_select "[name=?]", "web_numerical_results_group[order]"
      end
    end
  end
end
