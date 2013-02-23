require 'spec_helper'

describe "/web_tips/index.html.erb" do
  include WebTipsHelper

  before(:each) do
    assign(:web_tips, [
      stub_model(WebTip,
        :text => "value for text",
        :identifier => "value for identifier",
        :display_rules => "value for display_rules",
        :group_id => 1,
        :question_id => 1
      ),
      stub_model(WebTip,
        :text => "value for text",
        :identifier => "value for identifier",
        :display_rules => "value for display_rules",
        :group_id => 1,
        :question_id => 1
      )
    ])
  end

  it "renders a list of web_tips" do
    render
    assert_select("tr>td", "value for text".to_s, "2")
    assert_select("tr>td", "value for identifier".to_s, "2")
    assert_select("tr>td", "value for display_rules".to_s, "2")
  end
end
