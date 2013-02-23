require 'spec_helper'

describe User do
  describe '#default answer' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
      @situation = Factory(:situation, :case => @case)
      @first_group = Factory(:first_group)
      @first_question = Factory(:first_question, :group => @first_group)
      @expression_default_question = Factory(:expression_default_question, :group => @first_group)
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group]
      @default_answer = 'user given answer'
    end
    
    it "should get question's default answer when user has no saved situations" do
      default_answer = @user.default_answer @first_question, @session[:situation]
      default_answer.should == @first_question.attribute_value(:default_answer, @situation)
    end
    
    it "should get user's last saved answer when user has a saved situation" do
      @session[:situation][:groups][@first_group.name][:questions][@first_question.name][:answer] = @default_answer
      @situation.save_answers @session[:situation]
      default_answer = @user.default_answer @first_question, @session[:situation]
      default_answer.should == @default_answer
    end
    
    it "should get question's default answer when user has a saved situation but the default is an experssion" do
      @situation.save_answers @session[:situation]
      default_answer = @user.default_answer @expression_default_question, @session[:situation]
      default_answer.should == @expression_default_question.attribute_value(:default_answer, @situation)
    end

    it "should have fields allowing file sharing, receiving file sharing, and receiving email alerts about file sharing" do
      u = User.create(:login=>"joe", :email=> "joe@example.com", :password=> "funkypass", :password_confirmation=>"funkypass", :allow_fileshare => true, :receive_share_email=>true, :receive_fileshare=>true)
      u.save
    end
    
    it "should have a default active flag of 'true' " do
      @user.active? == true
    end

    it "should be soft deleted rather than hard deleted" do
      @user.destroy
      u = User.deleted.find_by_login(@user.login)
      u != nil
    end
    
    it "should not find a deleted record" do
      @user.destroy
      u = User.find_by_login(@user.login)
      u == nil
    end
  end
end
