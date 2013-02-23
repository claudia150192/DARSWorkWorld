require 'spec_helper'

describe "/web_tips/show.html.erb", :type => :request do
  include WebTipsHelper

  before(:each) do
    
    #assign(:web_tip,  stub_model(WebTip,
     # :text => "value for text",
     #:identifier => "value for identifier",
     # :display_rules => "value for display_rules",
     # :group_id => 1,
     # :question_id => 1
   # ))
    @tip = Factory(:web_tip)
    @user = Factory(:user)
    assign(:web_tip, @tip)
    
    render
  end

  it "renders attributes in <p>" do
    rendered.should =~ /#{Regexp.quote(@tip.text)}/
    rendered.should =~ /#{Regexp.quote(@tip.identifier)}/
    rendered.should =~ /#{Regexp.quote(@tip.display_rules)}/
  end
end

def current_user
  @user
end
