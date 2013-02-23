require 'spec_helper'

describe HelpController do
  describe "GET show" do
    let(:help) { mock_model(Help).as_null_object}
    before do
      Help.stub(:find_by_topic).and_return(help)
    end

    it "assigns @document" do
      get :show, :topic=>help
      assigns[:document].should eq(help)
    end

    it "renders the show template" do
      get :show, :topic=>help
      response.should render_template("show")
    end
  end
end
