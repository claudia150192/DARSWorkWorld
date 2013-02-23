require 'spec_helper'

describe "/layouts/pages.html.erb" do
  it "renders with the lang attribute set" do
    render
    assert_select "html[lang='en-US']"
  end
end
