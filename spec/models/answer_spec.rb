require 'spec_helper'

describe Answer do
  describe '#create' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
      @situation = Factory(:situation, :case => @case)
      @question = Factory(:question, :group_id => 1)
    end

    it "should create a new instance given valid attributes" do
      Factory(:answer, :situation => @situation, :question => @question)
    end
  
    it "should require an answer" do
      @answer = Factory.build(:answer, :situation => @situation, :answer => nil, :question => @question)
      @answer.should have(1).errors_on(:answer)
    end
  
    it "should require a situation" do
      @answer = Factory.build(:answer, :question => @question)
      @answer.should have(1).errors_on(:situation_id)
    end
  
    it "should require a question" do
      @answer = Factory.build(:answer, :situation => @situation)
      @answer.should have(1).errors_on(:question_id)
    end
  
    it "should be unique per question" do
      Factory(:answer, :situation => @situation, :question => @question)
      @answer = Factory.build(:answer, :situation => @situation, :question => @question)
      @answer.should have(1).errors_on(:question_id)
    end
  end
end
