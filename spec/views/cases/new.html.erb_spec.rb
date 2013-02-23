require 'spec_helper'

describe "/cases/new.html.erb" do
  include CasesHelper

  before(:each) do
    assign(:case, Case.new)
  end

  it "renders new case form" do
    render

    assert_select("form#new_case") do
      assert_select "[action=?]", cases_path
      assert_select "[method=post]"
      assert_select("input#case_user_id") do
        assert_select"[name=?]", "case[user_id]"
      end
      assert_select("input#case_name") do
        assert_select "[name=?]", "case[name]"
      end
    end
  end
end
