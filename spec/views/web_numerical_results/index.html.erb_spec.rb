require 'spec_helper'

describe "/web_numerical_results/index.html.erb" do
  include WebNumericalResultsHelper

  before(:each) do
    assign(:web_numerical_results, [
      stub_model(WebNumericalResult,
        :name => "value for name",
        :display_rules => "value for display_rules",
        :order => 1,
        :web_calc_id => 1,
        :group_id => 1
      ),
      stub_model(WebNumericalResult,
        :name => "value for name",
        :display_rules => "value for display_rules",
        :order => 1,
        :web_calc_id => 1,
        :group_id => 1
      )
    ])
  end

  it "renders a list of web_numerical_results" do
    render
    assert_select("tr>td", "value for name".to_s, "2")
    assert_select("tr>td", "value for display_rules".to_s, "2")
    assert_select("tr>td", 1.to_s, "2")
    assert_select("tr>td", 1.to_s, "2")
    assert_select("tr>td", 1.to_s, "2")
  end
end
