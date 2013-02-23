require 'spec_helper'

describe "/cases/edit.html.erb" do
  include CasesHelper

  before(:each) do
    @case = stub_model(Case,
      :new_record? => false,
      :user_id => 1,
      :name => "value for name",
    )
    assign(:case, @case)
  end

  it "renders the edit case form" do
    render
    assert_select("form.edit_case") do
        assert_select "[action=?]", case_path(@case)
        assert_select "[method=post]"
      assert_select('input#case_user_id') do
        assert_select '[name=?]', "case[user_id]"
      end
      assert_select('input#case_name') do
        assert_select '[name=?]', "case[name]"
      end
    end
  end
end
