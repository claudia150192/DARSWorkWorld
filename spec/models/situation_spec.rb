require 'spec_helper'

describe Situation do
  describe '#create' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
    end

    it "should create a new instance given valid attributes" do
      Factory(:situation, :case => @case)
    end
  
    it "should require a case" do
      @situation = Factory.build(:situation)
      @situation.should have(1).errors_on(:case_id)
    end
    
    it "should require a type" do
      @situation = Factory.build(:situation, :case => @case, :situation_type => nil)
      @situation.should have(1).errors_on(:situation_type)
    end
  end

  describe '#get_current_group' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
      @first_parent = Factory(:question_group)
      @root_group = Factory(:starting_group, :next_group => @first_parent)
      @second_group = Factory(:second_group, :parent=>@first_parent)
      @first_group = Factory(:first_group, :next_group=>@second_group, :parent=>@first_parent)
      @first_question = Factory(:first_question, :group => @first_group)
      @second_question = Factory(:second_question, :group => @first_group)
      @third_question = Factory(:third_question, :group=> @second_group)
      
      @root_question = Factory(:fourth_question, :group=> @root_group)
      
      @situation = Factory(:situation, :case=>@case)
    end

    it 'gets the root group when no questions are answered' do
      group = @situation.get_current_group
      group.should == @root_group
    end

    it 'gets the first group when one question is answered' do
      answer = Factory(:answer, :situation => @situation, :question=> @root_question)
      group = @situation.get_current_group
      group.should == @first_group
    end

    it 'gets the second_group when all questions in the first_group have been answered' do
      root_answer = Factory(:answer, :situation=>@situation, :question=>@root_question)
      a1 = Factory(:answer, :situation=>@situation, :question=>@first_question)
      a2 = Factory(:answer, :situation=>@situation, :question=>@second_question)
      group = @situation.get_current_group
      group.should == @second_group
    end

  end
  
  describe '#save answers' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
      @situation = Factory(:situation, :case => @case)
      @first_group = Factory(:first_group)
      @second_group = Factory(:second_group)
      @first_question = Factory(:first_question, :group => @first_group)
      @second_question = Factory(:second_question, :group => @first_group)
      @third_question = Factory(:third_question, :group => @second_group)
      @fourth_question = Factory(:fourth_question, :group => @second_group)
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group]
    end
    
    it "should save current situation state" do
      @situation.save_answers @session[:situation]
      @situation.answers.length.should == 2
    end
    
    it "should override previously saved answers" do
      @situation.save_answers @session[:situation]
      @session[:situation][:groups][@first_group.name][:questions][@first_question.name][:answer] = 'new answer'
      @session[:situation][:groups][@first_group.name][:questions][@second_question.name][:answer] = 'new answer'
      @situation.save_answers @session[:situation]
      @situation.answers.first.answer.should == 'new answer'
    end
    
    it "should retrieve last saved situation state" do
      @situation.save_answers @session[:situation]
      session = @situation.retrieve_answers
      session[:groups].keys.length.should == 1
      session[:groups][@first_group.name][:questions].keys.length.should == 2
    end
  end
  describe '#parent' do
    before(:each) do
      @user = Factory(:user)
      @case =Factory(:case, :user=>@user)
      @current = Factory(:situation, :case=>@case, :completed=>true)
    end

    it "can have a parent" do
      @whatif = Factory(:what_if, :case=>@case, :parent=> @current)
    end

    it "cannot have a parent if it is a current_situation" do
      @whatif = Factory(:situation, :case=>@case)
      @whatif.parent = @current
      @whatif.should have(1).errors_on(:parent)
    end

    it "cannot have a parent that is in a different case" do
      @case2 = Factory(:case, :user=>@user, :name=>"case2")
      @whatif = Factory(:what_if, :case=>@case2)
      @whatif.parent = @current
      @whatif.should have(1).errors_on(:parent)
    end
  end
end
