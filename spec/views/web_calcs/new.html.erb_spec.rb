require 'spec_helper'

describe "/web_calcs/new.html.erb" do
  include WebCalcsHelper

  before(:each) do
    assign(:web_calc, WebCalc.new)
  end

  it "renders new web_calc form" do
    render

    assert_select("form#new_web_calc") do
      assert_select "[action=?]", web_calcs_path
      assert_select "[method=post]" 
      assert_select("input#web_calc_name") do
        assert_select "[name=?]", "web_calc[name]"
      end
      assert_select("textarea#web_calc_operation") do
        assert_select "[name=?]", "web_calc[operation]"
      end
    end
  end
end
