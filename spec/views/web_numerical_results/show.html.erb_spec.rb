require 'spec_helper'

describe "/web_numerical_results/show.html.erb" do
  include WebNumericalResultsHelper
  before(:each) do
    @web_numerical_result = stub_model(WebNumericalResult,
      :name => "value for name",
      :display_rules => "value for display_rules",
      :order => 1,
      :web_calc_id => 1,
      :group_id => 1
    )
    assign(:web_numerical_result, @web_numerical_result)
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~ /value\ for\ name/
    rendered.should =~ (/value\ for\ display_rules/)
    rendered.should =~ (/1/)
    rendered.should =~ (/1/)
    rendered.should =~ (/1/)
  end
end
