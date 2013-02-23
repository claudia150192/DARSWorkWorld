require 'spec_helper'

describe "/web_tips/edit.html.erb" do
  include WebTipsHelper

  before(:each) do
    @web_tip = stub_model(WebTip,
      :new_record? => false,
      :text => "value for text",
      :identifier => "value for identifier",
      :display_rules => "value for display_rules",
      :group_id => 1,
      :question_id => 1
    )
    assign(:web_tip, @web_tip)
  end

  it "renders the edit web_tip form" do
    render
    
    assert_select "form.edit_web_tip" do
      assert_select "[action=?]", web_tip_path(@web_tip)
      assert_select "[method=post]"
    end
    assert_select "form.edit_web_tip textarea#web_tip_text" do
      assert_select "[name='web_tip[text]']"
    end
    assert_select "form.edit_web_tip input#web_tip_identifier" do
      assert_select "[name='web_tip[identifier]']"
    end
    assert_select "form.edit_web_tip textarea#web_tip_display_rules" do
      assert_select "[name='web_tip[display_rules]']"
    end
  end
end
