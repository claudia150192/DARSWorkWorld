require 'spec_helper'

describe "/web_calcs/show.html.erb" do
  include WebCalcsHelper
  before(:each) do
    assign(:web_calc, stub_model(WebCalc,
      :name => "value for name",
      :operation => "value for operation"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should =~(/value\ for\ name/)
    rendered.should =~(/value\ for\ operation/)
  end
end
