require 'spec_helper'

describe "chart_results/edit.html.erb" do
  before(:each) do
    @chart_result = assign(:chart_result, stub_model(ChartResult,
      :name => "MyString",
      :formula => "MyString",
      :chart => nil
    ))
  end

  it "renders the edit chart_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chart_results_path(@chart_result), :method => "post" do
      assert_select "input#chart_result_name", :name => "chart_result[name]"
      assert_select "input#chart_result_formula", :name => "chart_result[formula]"
      assert_select "input#chart_result_chart", :name => "chart_result[chart]"
    end
  end
end
