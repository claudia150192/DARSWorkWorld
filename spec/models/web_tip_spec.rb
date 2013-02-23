require 'spec_helper'

describe WebTip do
  before(:each) do
    @valid_attributes = {
      :text => "value for text",
      :identifier => "value for identifier",
      :display_rules => "always",
      :group_id => 1,
      :workbook_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    WebTip.create!(@valid_attributes)
  end
end
