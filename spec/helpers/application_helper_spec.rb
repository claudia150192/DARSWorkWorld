require 'spec_helper'
require 'ruby-debug'
describe ApplicationHelper do
  describe "#calculate(text, situation)" do
    context "when the webcalc does a simple string" do
      before(:each) do
        @calc = Factory(:web_calc) 
      end
      it "interpolates the webcalc operation" do
        
        text = "I want to add T{" + @calc.name + "} text"
        content = helper.calculate(text, {}) # not dependent on the situation for this one
        content.should match @calc.operation
      end
    end
  end
end
