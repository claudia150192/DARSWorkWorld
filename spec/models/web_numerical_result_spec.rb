require 'spec_helper'

describe WebNumericalResult do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :text => "value for text",
      :display_rules => "always",
      :order => 1,
      :web_calc_id => 1,
      :group_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    WebNumericalResult.create!(@valid_attributes)
  end
end
