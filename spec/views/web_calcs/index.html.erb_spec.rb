require 'spec_helper'

describe "/web_calcs/index.html.erb" do
  include WebCalcsHelper

  before(:each) do
    assign(:web_calcs, [
      stub_model(WebCalc,
        :name => "value for name",
        :operation => "value for operation"
      ),
      stub_model(WebCalc,
        :name => "value for name",
        :operation => "value for operation"
      )
    ])
  end

  it "renders a list of web_calcs" do
    render
    assert_select("tr>td", "value for name".to_s, "2")
    assert_select("tr>td", "value for operation".to_s, "2")
  end
end
