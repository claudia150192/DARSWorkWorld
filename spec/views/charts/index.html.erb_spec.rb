require 'spec_helper'

describe "charts/index.html.erb" do
  before(:each) do
    assign(:charts, [
      stub_model(Chart,
        :chart_type => "Chart Type",
        :title => "Title",
        :yaxis_label => "Yaxis Label"
      ),
      stub_model(Chart,
        :chart_type => "Chart Type",
        :title => "Title",
        :yaxis_label => "Yaxis Label"
      )
    ])
  end

  it "renders a list of charts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Chart Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Yaxis Label".to_s, :count => 2
  end
end
