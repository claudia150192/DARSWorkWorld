require 'spec_helper'

describe "chart_results/show.html.erb" do
  before(:each) do
    @chart_result = assign(:chart_result, stub_model(ChartResult,
      :name => "Name",
      :formula => "Formula",
      :chart => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Formula/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
