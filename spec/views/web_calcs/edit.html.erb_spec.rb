require 'spec_helper'

describe "/web_calcs/edit.html.erb" do
  include WebCalcsHelper

   
   before(:each) do
     @web_calc = stub_model(WebCalc,
       :new_record? => false,
       :name => "value for name",
       :operation => "value for operation"
     )
     assign(:web_calc, @web_calc) 
   end
 
   it "renders the edit web_calc form" do
     render
     assert_select("form.edit_web_calc") do
      assert_select "[action=?]", web_calc_path(@web_calc)
      assert_select "[method=post]"

      assert_select('input#web_calc_name') do
        assert_select '[name=?]', "web_calc[name]"
      end
      assert_select('textarea#web_calc_operation') do
        assert_select '[name=?]', "web_calc[operation]"
      end
     end
   end
end
