require 'spec_helper'

describe WebTipsHelper do

  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(WebTipsHelper)
  end

end
