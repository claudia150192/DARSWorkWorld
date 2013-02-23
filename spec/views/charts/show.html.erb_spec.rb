require 'spec_helper'

describe "charts/show.html.erb" do
  before(:each) do
    @chart = assign(:chart, stub_model(Chart,
      :chart_type => "Chart Type",
      :title => "Title",
      :yaxis_label => "Yaxis Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Chart Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Yaxis Label/)
  end
end
