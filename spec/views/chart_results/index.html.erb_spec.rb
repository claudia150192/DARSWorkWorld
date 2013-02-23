require 'spec_helper'

describe "chart_results/index.html.erb" do
  before(:each) do
    assign(:chart_results, [
      stub_model(ChartResult,
        :name => "Name",
        :formula => "Formula",
        :chart => nil
      ),
      stub_model(ChartResult,
        :name => "Name",
        :formula => "Formula",
        :chart => nil
      )
    ])
  end

  it "renders a list of chart_results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Formula".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
