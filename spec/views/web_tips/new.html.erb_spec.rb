require 'spec_helper'

describe "/web_tips/new.html.erb" do
  include WebTipsHelper

  before(:each) do
    assign(:web_tip, WebTip.new)
  end

  it "renders new web_tips form" do
    render
    
    assert_select "form#new_web_tip" do
      assert_select "[action=?]", web_tips_path
    end
    assert_select "form#new_web_tip textarea#web_tip_text" do
      assert_select "[name='web_tip[text]']"
    end
    assert_select "form#new_web_tip input#web_tip_identifier" do
      assert_select "[name='web_tip[identifier]']"
    end
    assert_select "form#new_web_tip textarea#web_tip_display_rules" do
      assert_select "[name='web_tip[display_rules]']"
    end
  end
end
