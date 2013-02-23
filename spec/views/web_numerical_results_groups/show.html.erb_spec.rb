require 'spec_helper'

describe "/web_numerical_results_groups/show.html.erb" do
  include WebNumericalResultsGroupsHelper
  before(:each) do
    @web_numerical_results_group = stub_model(WebNumericalResultsGroup,
      :name => "value for name",
      :order => 1
    )
    assign(:web_numerical_results_group, @web_numerical_results_group)
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~ /value\ for\ name/
    rendered.should =~ /1/
  end
end
