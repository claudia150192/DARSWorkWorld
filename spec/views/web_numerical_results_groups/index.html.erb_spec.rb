require 'spec_helper'

describe "/web_numerical_results_groups/index.html.erb" do
  include WebNumericalResultsGroupsHelper

  before(:each) do
    assign(:web_numerical_results_groups, [
      stub_model(WebNumericalResultsGroup,
        :name => "value for name",
        :order => 1
      ),
      stub_model(WebNumericalResultsGroup,
        :name => "value for name",
        :order => 1
      )
    ])
  end

  it "renders a list of web_numerical_results_groups" do
    render
    assert_select "tr>td", "value for name".to_s, "2"
    assert_select "tr>td", 1.to_s, "2"
  end
end
