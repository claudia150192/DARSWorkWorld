require 'spec_helper'
require 'ruby-debug'
describe SituationsController do
  before(:each) do
    @user = Factory(:user)
    @case = Factory(:case, :user=>@user)
    @situation = Factory(:situation, :case=>@case)

    @first_parent = Factory(:question_group)
    @root_group = Factory(:starting_group, :next_group => @first_parent)
    @second_group = Factory(:second_group, :parent=>@first_parent)
    @first_group = Factory(:first_group, :next_group=>@second_group, :parent=>@first_parent)
    @first_question = Factory(:first_question, :group => @first_group)
    @second_question = Factory(:second_question, :group => @first_group)
    @third_question = Factory(:third_question, :group=> @second_group)
    
    @root_question = Factory(:fourth_question, :group=> @root_group)
  end

  describe "POST /cases/:case_id/situations/:id/accept" do
    let(:situation) {mock_model(Situation).as_null_object}
    before do
      Situation.stub(:save_answers).and_return(nil)
      Situation.stub(:find_by_id).and_return(situation)
    end

    it "fetches the situation from the database" do
      situation.should_receive(:find_by_id)
      post :accept, :situation=>@situation, :case_id=>@case.id, :id=>@situation.id
    end

    it "saves the situation" do
      situation.should_receive(:save_answers)
      post :accept, :situation=> @situation, :case_id=> @case.id, :id=>@situation.id
    end
  end

  describe "GET /cases/:case_id/situation/new" do
    before(:each) do
      Case.stub(:find_by_id).and_return(@case)
      @situation.complete!
      @whatif = Factory(:what_if, :case=>@case, :parent=>@situation)
      get :new, :case_id=>@case.id
    end

    it "renders the new template" do
      response.should render_template
    end

    it "assigns a list of situations associated with the case id" do
      assigns[:case].should have(2).situations
    end
  end

  describe "POST /cases/:case_id/situations" do
  end
end
