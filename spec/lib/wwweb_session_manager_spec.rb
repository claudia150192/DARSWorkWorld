require 'spec_helper'

describe WWWebSessionManager do
  describe "#get answers" do
    before(:each) do
      @session = {}
      @session = { :situation => {:groups => { "test_group" => {} }}}
      @session[:situation][:groups]["test_group"] = { :questions => { 
        "test_question" => { :answer => "test answer" }, 
        "another question" => { :answer => "another answer" }
      } }
      @manager = WWWebSessionManager.new(@session[:situation])
    end
    
    it "should return null if session is nil" do
      @manager.situation = nil
      @manager.get_answer_by_question_name("test_question").should == nil
    end
    
    it "should return null if session is empty" do
      @manager.situation = {}
      @manager.get_answer_by_question_name("test_question").should == nil
    end
    
    it "should retrieve answer knowing question name" do
      @manager.get_answer_by_question_name("test_question").should == "test answer"
    end
    
    it "should retrieve answer knowing question and group name" do
      @manager.get_answer_by_group_and_question_name("test_group", "test_question").should == "test answer"
    end
    
    it "should retrieve list of questions from session" do
      @session[:situation][:groups]["test_group2"] = { :questions => { 
        "test_question2" => { :answer => "test answer" }, 
        "another question2" => { :answer => "another answer" }
      } }
      @manager.situation = @session[:situation]
      @manager.get_list_of_questions.length.should == 4
    end
    
    it "should return an empty array when list of questions is empty" do
      @session[:situation][:groups] = { "test_group" => {}, "test_group2" => { :questions => {} }}
      @manager.situation = @session[:situation]
      @manager.get_list_of_questions.length.should == 0
    end
    
    it "should return an empty array when list of groups is empty" do
      @session[:situation][:groups] = {}
      @manager.situation = @session[:situation]
      @manager.get_list_of_questions.length.should == 0
    end
  end
  
  describe "#setup session for group" do
    before(:each) do
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @group = Factory(:question_group)
      @question1 = Factory(:question, :group => @group)
      @question2 = Factory(:question, :name => "question 2", :group => @group)
    end
    
    it "should setup session for group in one-by-one mode" do
      @manager.setup_session_for_group @group, WWWebSessionManager::MODES[:one_at_a_time]
      @session[:situation][:groups][@group.name][:questions].length.should == 1
    end
    
    it "should setup session for group in one-by-one mode and get the right first question" do
      @question1.display_rules = "false"
      @question1.save
      @manager.setup_session_for_group @group, WWWebSessionManager::MODES[:one_at_a_time]
      @session[:situation][:groups][@group.name][:questions].length.should == 1
      @session[:situation][:groups][@group.name][:questions].keys.first.should == @question2.name
    end
    
    it "should setup session for group in group mode" do
      @manager.setup_session_for_group @group, WWWebSessionManager::MODES[:group]
      @session[:situation][:groups][@group.name][:questions].length.should == 2
    end
    
    it "should be able to know if session has been setup for a group and return false when it isn't" do
      @manager.is_group_setup?(@group).should be_false
    end
    
    it "should be able to know if session has been setup for a group and return true when it is" do
      @manager.setup_session_for_group @group, WWWebSessionManager::MODES[:group]
      @manager.is_group_setup?(@group).should be_true
    end
    
    it "should be able to know if session has been setup for a group and return false when it isn't (parent group)" do
      @parent_group = Factory(:question_group, :name => 'parent')
      @sub_group_1 = QuestionGroup.create!(:name => "Sub Group 1", :workbook_order=> 1)
      @parent_group.sub_groups << @sub_group_1
      @manager.is_group_setup?(@parent_group).should be_false
    end
    
    it "should be able to know if session has been setup for a group and return true when it is (parent group)" do
      @parent_group = Factory(:question_group, :name => 'parent')
      @sub_group_1 = QuestionGroup.create!(:name => "Sub Group 1", :workbook_order=> 1)
      @parent_group.sub_groups << @sub_group_1
      @question3 = Factory(:question, :name => "question 3", :group => @sub_group_1)
      @manager.setup_session_for_group @sub_group_1, WWWebSessionManager::MODES[:group]
      @manager.is_group_setup?(@sub_group_1).should be_true
      @manager.is_group_setup?(@parent_group).should be_true
    end
  end
  
  describe "#initialize situation session" do
    before(:each) do
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @second_group = Factory(:second_group)
      @first_group = Factory(:first_group, :next_group => @second_group)
      @question1 = Factory(:question, :group => @first_group)
      @question2 = Factory(:question, :name => "question 2", :group => @first_group)
      @question3 = Factory(:question, :name => "question 3", :group => @second_group)
    end
    
    it "should initialize session with first group" do
      @session[:situation] = @manager.initialize_situation
      @session[:situation][:groups].length.should == 1
      @session[:situation][:groups].keys.first.should == @first_group.name
    end
    
    it "should initialize session with second group if first group isn't displayable" do
      @question1.display_rules = "false"
      @question1.save
      @question2.display_rules = "false"
      @question2.save
      @session[:situation]  = @manager.initialize_situation
      @session[:situation][:groups].keys.length.should == 1
      @session[:situation][:groups].keys.first.should == @second_group.name
    end
    
    it "should initialize session with first group in one-by-one mode" do
      @session[:situation]  = @manager.initialize_situation
      key = @session[:situation][:groups].keys.first
      @session[:situation][:groups][key][:questions].keys.length.should == 1
    end
    
    it "should initialize session with first group in group mode" do
      @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group]
      key = @session[:situation][:groups].keys.first
      @session[:situation][:groups][key][:questions].keys.length.should == 2
    end
  end
  
  describe "#situation workflow" do
    before(:each) do
      @first_group = Factory(:first_group)
      @second_group = Factory(:second_group)
      @first_group.next_group = @second_group
      @first_question = Factory(:first_question, :group => @first_group)
      @second_question = Factory(:second_question, :group => @first_group)
      @third_question = Factory(:third_question, :group => @second_group)
      @fourth_question = Factory(:fourth_question, :group => @second_group)
      @fifth_question = Factory(:fifth_question, :group => @second_group)
      @first_group.save
      @second_group.save
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
    end
    describe "#one-at-a-time mode" do
      before(:each) do
        @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:one_at_a_time]
      end
      
      it "should add first question answer to session" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @session[:situation][:groups].keys.length.should == 1
        @session[:situation][:groups][@first_group.name][:questions].keys.length.should == 1
        @session[:situation][:groups][@first_group.name][:questions][@first_question.name][:answer].should == @first_question.default_answer
      end
      
      it "should add second question answer to session" do
        params = { :groups => { @first_group.name => { :questions => { 
          @first_question.name => @first_question.default_answer, 
          @second_question.name => @second_question.default_answer
        }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @session[:situation][:groups].keys.length.should == 1
        @session[:situation][:groups][@first_group.name][:questions].keys.length.should == 2
        @session[:situation][:groups][@first_group.name][:questions][@first_question.name][:answer].should == @first_question.default_answer
        @session[:situation][:groups][@first_group.name][:questions][@second_question.name][:answer].should == @second_question.default_answer
      end
      
      it "should only include second question answer in session when first question is not displayed" do
        params = { :groups => { @first_group.name => { :questions => { 
          @second_question.name => @second_question.default_answer
        }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @session[:situation][:groups].keys.length.should == 1
        @session[:situation][:groups][@first_group.name][:questions].keys.length.should == 1
        @session[:situation][:groups][@first_group.name][:questions][@second_question.name][:answer].should == @second_question.default_answer
      end
      
      it "should check if a question has been shown and return true when it has" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.question_has_been_shown?(@first_question.name).should == true
      end
      
      it "should check if a question has been shown and return false when it hasn't" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.question_has_been_shown?(@second_question.name).should == false
      end
      
      it "should check if a question's answer has been accepted and return false if it hasn't" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.question_has_been_accepted?(@second_question.name).should == false
      end
      
      it "should check if a question's answer has been accepted and return true if it has" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.question_has_been_accepted?(@first_question.name).should == true
      end
      
      it "should check if all questions have been accepted for group and return false if not" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.group_questions_have_been_accepted?(@first_group).should == false
      end
      
      it "should check if all questions have been accepted for group and return true if yes" do
        params = { :groups => { @first_group.name => { :questions => { 
          @first_question.name => @first_question.default_answer,
          @second_question.name => @second_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.group_questions_have_been_accepted?(@first_group).should == true
      end
      
      it "should check if all previous groups have been accepted for group and return false if not" do
        params = { :groups => { @first_group.name => { :questions => { @first_question.name => @first_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.previous_groups_have_been_accepted?(@second_group).should == false
      end
      
      it "should check if all previous groups have been accepted for group and return true if yes" do
        params = { :groups => { @first_group.name => { :questions => { 
          @first_question.name => @first_question.default_answer,
          @second_question.name => @second_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.previous_groups_have_been_accepted?(@second_group).should == true
      end
      
      it "should check if all previous groups are valid and return false if not" do
        @first_question.validation_rules = "
        answer = manager.get_answer_by_question_name(self.name)
        answer != 'invalid answer'"
        @first_question.validation_message = "Answer must be valid"
        @first_question.save
        params = { :groups => { @first_group.name => { :questions => { 
          @first_question.name => 'invalid answer',
          @second_question.name => @second_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.previous_groups_are_valid?(@second_group).should == false
      end
      
      it "should check if all previous groups are valid and return true if yes" do
        @first_question.validation_rules = "
        answer = manager.get_answer_by_question_name(self.name)
        answer != 'invalid answer'"
        @first_question.validation_message = "Answer must be valid"
        @first_question.save
        params = { :groups => { @first_group.name => { :questions => { 
          @first_question.name => @first_question.default_answer,
          @second_question.name => @second_question.default_answer }, :id => @first_group.id }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @manager.previous_groups_are_valid?(@second_group).should == true
      end
    end
    
    describe '#group mode' do
      before(:each) do
        @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group]
      end
      
      it "should check if group has question answers in session" do
        @manager.group_has_answers?(@first_group.name).should == true
      end
    end
    
    describe '#editing mode' do
      before(:each) do
        @fourth_question.display_rules = "!manager.get_answer_by_question_name('#{@first_question.name}').blank?"
        @fourth_question.save
      end
      
      it "should setup group while keeping valid submitted answers in group mode" do
        @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group]
        params = { :groups => { @second_group.name => { :id => @second_group.id, 
          :questions => { 
            @third_question.name => @third_question.default_answer,
            @fourth_question.name => @fourth_question.default_answer,
            @fifth_question.name => 'not default answer'
          } 
        }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        params = { :groups => { @first_group.name => { :id => @first_group.id, 
          :questions => { 
            @second_question.name => @second_question.default_answer
          } 
        }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @session[:situation] = @manager.setup_session_for_group @second_group, WWWebSessionManager::MODES[:group]
        @session[:situation][:groups][@second_group.name][:questions][@fourth_question.name].should == nil
        @session[:situation][:groups][@second_group.name][:questions][@fifth_question.name][:answer].should == 'not default answer'
      end
    
      it "should setup group while keeping valid submitted answers in one_at_a_time mode" do
        @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:one_at_a_time]
        params = { :groups => { @second_group.name => { :id => @second_group.id, 
          :questions => { 
            @third_question.name => @third_question.default_answer,
            @fourth_question.name => @fourth_question.default_answer,
            @fifth_question.name => 'not default answer'
          } 
        }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        params = { :groups => { @first_group.name => { :id => @first_group.id, 
          :questions => { 
            @second_question.name => @second_question.default_answer
          } 
        }}}
        @session[:situation] = @manager.add_group_answers_to_session params
        @session[:situation] = @manager.setup_session_for_group @second_group, WWWebSessionManager::MODES[:one_at_a_time]
        @session[:situation][:groups][@second_group.name][:questions][@fourth_question.name].should == nil
        @session[:situation][:groups][@second_group.name][:questions][@fifth_question.name][:answer].should == 'not default answer'
      end
    end
  end
  
  describe '#saving situations' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user => @user)
      @situation = Factory(:situation, :case => @case)
      @first_group = Factory(:first_group)
      @first_question = Factory(:first_question, :group => @first_group)
      @second_question = Factory(:second_question, :group => @first_group)
      @first_answer = Factory(:answer, :situation => @situation, :question => @first_question)
      @second_answer = Factory(:answer, :answer => 'new answer', :situation => @situation, :question => @second_question)
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
    end
    
    it "should add saved answer to session hash" do
      @session[:situation] = @manager.add_saved_answer @first_answer
      @manager.get_answer_by_question_name(@first_question.name).should == @first_answer.answer
      @session[:situation][:groups][@first_group.name][:questions][@first_question.name][:answer].should == @first_answer.answer
    end
    
    it "should add situation id" do
      @manager.add_situation @situation
      @manager.get_situation_id.should == @situation.id
    end
    
    it "should add situation mode" do
      @manager.add_situation @situation
      @manager.get_mode.should == @situation.mode
    end
    
    it "should return nil when no saved situation is found" do
      @manager.get_situation_id.should == nil
    end
    
    it "should initialize new situation with saved answers" do
      @session[:situation] = @manager.add_saved_answer @second_answer
      @situation.save_answers @session[:situation]
      @session[:situation]  = @manager.initialize_situation WWWebSessionManager::MODES[:group], @user
      @manager.get_answer_by_question_name(@second_question.name).should == 'new answer'
    end
  end
  
  describe '#web tips' do
    before(:each) do
      @first_group = Factory(:first_group)
      @first_question = Factory(:first_question, :group => @first_group)
      @web_tip = Factory(:web_tip, :group => @first_group)
      @non_default_first_question_web_tip = Factory(:non_default_first_question_web_tip, :group => @first_group)
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
    end
    
    it "should setup group's web tips for session" do
      @session[:situation] = @manager.setup_web_tips @first_group
      @session[:situation][:groups][@first_group.name][:web_tips].keys.length.should == 1
      @session[:situation][:groups][@first_group.name][:web_tips][@web_tip.id][:new].should == false
    end
    
    it "should update list of web tips after change of answer" do
      @session[:situation] = @manager.setup_web_tips @first_group
      params = { :groups => { @first_group.name => { :questions => { 
        @first_question.name => 'not default answer'
      }, :id => @first_group.id }}}
      @session[:situation] = @manager.add_group_answers_to_session params
      @session[:situation] = @manager.update_web_tips @first_group
      @session[:situation][:groups][@first_group.name][:web_tips].keys.length.should == 2
      @session[:situation][:groups][@first_group.name][:web_tips][@web_tip.id][:new].should == false
      @session[:situation][:groups][@first_group.name][:web_tips][@non_default_first_question_web_tip.id][:new].should == true
    end
    
    it "should remove non displayable tip after change of answer" do
      @session[:situation] = @manager.setup_web_tips @first_group
      params = { :groups => { @first_group.name => { :questions => { 
        @first_question.name => 'not default answer'
      }, :id => @first_group.id }}}
      @session[:situation] = @manager.add_group_answers_to_session params
      @session[:situation] = @manager.update_web_tips @first_group
      params = { :groups => { @first_group.name => { :questions => { 
        @first_question.name => @first_question.default_answer
      }, :id => @first_group.id }}}
      @session[:situation] = @manager.add_group_answers_to_session params
      @session[:situation] = @manager.update_web_tips @first_group
      @session[:situation][:groups][@first_group.name][:web_tips].keys.length.should == 1
      @session[:situation][:groups][@first_group.name][:web_tips][@web_tip.id][:new].should == false
    end
    
    it "should retrieve all non new tips" do
      @session[:situation] = @manager.setup_web_tips @first_group
      params = { :groups => { @first_group.name => { :questions => { 
        @first_question.name => 'not default answer'
      }, :id => @first_group.id }}}
      @session[:situation] = @manager.add_group_answers_to_session params
      @session[:situation] = @manager.update_web_tips @first_group
      tips = @manager.get_non_new_tips @first_group
      tips.length.should == 1
    end
    
    it "should retrieve all new tips" do
      @session[:situation] = @manager.setup_web_tips @first_group
      params = { :groups => { @first_group.name => { :questions => { 
        @first_question.name => 'not default answer'
      }, :id => @first_group.id }}}
      @session[:situation] = @manager.add_group_answers_to_session params
      @session[:situation] = @manager.update_web_tips @first_group
      tips = @manager.get_new_tips @first_group
      tips.length.should == 1
    end
  end
  
end
