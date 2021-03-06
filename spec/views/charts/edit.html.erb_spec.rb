require 'spec_helper'

describe "charts/edit.html.erb" do
  before(:each) do
    @chart = assign(:chart, stub_model(Chart,
      :chart_type => "MyString",
      :title => "MyString",
      :yaxis_label => "MyString"
    ))
  end

  it "renders the edit chart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => charts_path(@chart), :method => "post" do
      assert_select "input#chart_chart_type", :name => "chart[chart_type]"
      assert_select "input#chart_title", :name => "chart[title]"
      assert_select "input#chart_yaxis_label", :name => "chart[yaxis_label]"
    end
  end
end
