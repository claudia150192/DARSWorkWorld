require 'spec_helper'

describe "chart_results/new.html.erb" do
  before(:each) do
    assign(:chart_result, stub_model(ChartResult,
      :name => "MyString",
      :formula => "MyString",
      :chart => nil
    ).as_new_record)
  end

  it "renders new chart_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chart_results_path, :method => "post" do
      assert_select "input#chart_result_name", :name => "chart_result[name]"
      assert_select "input#chart_result_formula", :name => "chart_result[formula]"
      assert_select "input#chart_result_chart", :name => "chart_result[chart]"
    end
  end
end
