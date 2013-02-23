require 'spec_helper'

describe QuestionGroup do
  describe "#create" do
    before(:each) do
      @valid_attributes = {
        :name => "value for name",
        :workbook_order => 1
      }
      @invalid_attributes = {
        :name => ""
      }
    end

    it "should create a new instance given valid attributes" do
      QuestionGroup.create!(@valid_attributes)
    end
    
    it "should require a name" do
      @question_group = QuestionGroup.new(@invalid_attribues)
      @question_group.should have(1).errors_on(:name)
    end
  end
  
  describe "#relationships" do
    before(:each) do
      @group = Factory(:question_group)
    end

    it "should be able to have many sub groups" do
      @sub_group_1 = QuestionGroup.create!(:name => "Sub Group 1", :workbook_order => 1)
      @group.sub_groups << @sub_group_1
      @sub_group_2 = QuestionGroup.create!(:name => "Sub Group 2", :workbook_order => 2)
      @group.sub_groups << @sub_group_2
      @sub_group_1.parent_id.should == @group.id
      @sub_group_1.parent.should == @group
      @group.sub_groups.should have(2).items
    end
    
    it "should be able to have many questions" do
      @question = Factory.build(:question_without_group)
      @group.questions << @question
      @question.save
      @question.group_id.should == @group.id
      @question.group.should == @group
      @group.questions.should have(1).items
    end
  end
  
  describe "#hierarchy" do
    before(:each) do
      @parent = Factory(:question_group)
      @next_parent = Factory(:question_group, :name => 'next', :previous_group => @parent)
      @child = Factory(:child_group, :parent => @parent)
    end
    
    it "should be a parent" do
      @parent.is_parent?.should be_true
    end
    
    it "should be a child" do
      @child.is_child?.should be_true
    end
    
    it "should fetch next group if next group should show" do
      @session = {}
      @group = QuestionGroup.create!(:name => "Previous Group", :workbook_order => 1)
      @group.next_group = @parent
      @group.save
      @question = Factory(:question, :group => @child)
      @group.fetch_next_group(@session).should == @child
    end
    
    it "should get a nil object if next group should not show" do
      @session = {}
      @group = QuestionGroup.create!(:name => "Previous Group", :workbook_order => 1)
      @group.next_group = @parent
      @group.save
      @group.fetch_next_group(@session).should == nil
    end
    
    it "should get parent groups" do
      QuestionGroup.parent_groups.size.should == 1
    end
    
    it "should fetch the first displayable child and return nil if none are displayable" do
      @parent.fetch_first_displayable_child({}).should be_nil
    end
    
    it "should fetch the first displayable child and return a group" do
      @question1 = Factory(:question, :group => @child)
      @child.save
      @parent.save
      @child.show?({}).should be_true
      @parent.fetch_first_displayable_child({}).should == @child
    end
  end
  
  describe "#show" do
    before(:each) do
      @group = Factory(:question_group)
      @question1 = Factory(:question, :group => @group)
      @question2 = Factory(:question, :name => "question 2", :group => @group)
      @session = {}
    end
    
    it "should show when at least one question shows" do
      @group.show?(@session).should be_true
    end
    
    it "should not show when questions is blank" do
      @group.questions = []
      @group.show?(@session).should be_false
    end
    
    it "should not show when no question shows" do
      @question1.display_rules = "false"
      @question1.save
      @question2.display_rules = "false"
      @question2.save
      @group.show?(@session).should be_false
    end
  end
  
  describe "#answer validation" do
    describe "#valid answers" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:question, :group => @group)
        @session = {}
        @session = { :situation => {:groups => { @group.name => {} }}}
        @session[:situation][:groups][@group.name] = { :questions => { 
          @question.name => { :answer => 200, :accepted => false }
        } }
      end
    
      it "should validate" do
        @group.validates?(@session[:situation]).should be_true
      end
      
      it "should not have errors" do
        @group.validates?(@session[:situation])
        @group.has_validation_errors?.should be_false
      end
    end
    
    describe "#invalid answers" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:question, :group => @group)
        @session = {}
        @session = { :situation => {:groups => { @group.name => {} }}}
        @session[:situation][:groups][@group.name] = { :questions => { 
          @question.name => { :answer => "text", :accepted => false }
        } }
      end
    
      it "should not validate" do
        @group.validates?(@session[:situation]).should be_false
      end
      
      it "should have errors" do
        @group.validates?(@session[:situation])
        @group.has_validation_errors?.should be_true
      end
    end
  end
  
  describe "#get first displayable question" do
    before(:each) do
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @group = Factory(:question_group)
      @first_question = Factory(:first_question, :group => @group)
      @second_question = Factory(:second_question, :group => @group)
    end
    
    it "should get the first question in the list" do
      @group.get_first_displayable_question(@session[:situation]).should == @first_question
    end
    
    it "should get the next question in the list if the first is not displayable" do
      @first_question.display_rules = "false"
      @first_question.save
      @group.get_first_displayable_question(@session[:situation]).should == @second_question
    end
    
    it "should return nil if none are displayable" do
      @first_question.display_rules = "false"
      @second_question.display_rules = "false"
      @first_question.save
      @second_question.save
      @group.get_first_displayable_question(@session[:situation]).should == nil
    end
    
    it "should return next question if display rules validate according to situation" do
      @first_question.display_rules = "false"
      @second_question.display_rules = "manager.get_answer_by_question_name('#{@first_question.name}') == nil"
      @first_question.save
      @second_question.save
      @group.get_first_displayable_question(@session[:situation]).should == @second_question
    end
    
    it "should return nil if display rules do not validate according to situation" do
      @first_question.display_rules = "false"
      @second_question.display_rules = "answer = manager.get_answer_by_question_name('#{@first_question.name}') != nil"
      @first_question.save
      @second_question.save
      @group.get_first_displayable_question(@session[:situation]).should == nil
    end
  end
  
  describe "#get next displayable question" do
    before(:each) do
      @session = { :situation => {} }
      @manager = WWWebSessionManager.new(@session[:situation])
      @group = Factory(:question_group)
      @first_question = Factory(:first_question, :group => @group)
      @second_question = Factory(:second_question, :group => @group)
      @session[:situation] = { :groups => { @group.name => {
        :id => @group.id,
        :questions => { @first_question.name => { :answer => @first_question.default_answer, :accepted => true } }
      }}}
    end
    
    it "should get the first question in the list when none have already been fetched" do
      @session[:situation] = { :groups => { @group.name => {
        :id => @group.id,
        :questions => {  } 
      }}}
      @group.get_next_displayable_question(@session[:situation]).should == @first_question
    end
    
    it "should get the second question in the list when first one has already been fetched" do
      @group.get_next_displayable_question(@session[:situation]).should == @second_question
    end
    
    it "should get the next question in the list if the first is not displayable" do
      @session[:situation] = { :groups => { @group.name => {
        :id => @group.id,
        :questions => {  } 
      }}}
      @first_question.display_rules = "false"
      @first_question.save
      @group.get_next_displayable_question(@session[:situation]).should == @second_question
    end
    
    it "should return nil if none are displayable" do
      @session[:situation] = { :groups => { @group.name => {
        :id => @group.id,
        :questions => {  } 
      }}}
      @first_question.display_rules = "false"
      @second_question.display_rules = "false"
      @first_question.save
      @second_question.save
      @group.get_next_displayable_question(@session[:situation]).should == nil
    end
    
    it "should return nil if the first one has been fetched and the second one isn't displayable" do
      @second_question.display_rules = "false"
      @second_question.save
      @group.get_next_displayable_question(@session[:situation]).should == nil
    end
    
    it "should return the second question if the first one has been fetched and the second one's display rules validate according to situation" do
      @second_question.display_rules = "manager.get_answer_by_question_name('#{@first_question.name}') == '#{@first_question.default_answer}'"
      @second_question.save
      @group.get_next_displayable_question(@session[:situation]).should == @second_question
    end
    
    it "should return nil if the first one has been fetched and the second one's display rules doesn't validate according to situation" do
      @second_question.display_rules = "manager.get_answer_by_question_name('#{@first_question.name}') != '#{@first_question.default_answer}'"
      @second_question.save
      @group.get_next_displayable_question(@session[:situation]).should == nil
    end
  end
  
  describe '#navigation' do
    before(:each) do
      @first_group = Factory(:first_group) # group with dislpayble questions
      @second_group = Factory(:second_group, :previous_group => @first_group) # group with dislpayble questions
      @third_group = Factory(:question_group, :name => 'third group', :previous_group => @second_group) # group with child group with displayable questions
      @fourth_group = Factory(:question_group, :name => 'fourth group', :previous_group => @third_group) # group withouth displayable questions but linked
      @fifth_group = Factory(:question_group, :name => 'fifth group', :previous_group => @fourth_group) # group with child group without displayable questions but linked
      @sixth_group = Factory(:question_group, :name => 'sixth group') # group with displayable questions but not linked
      @child_group = Factory(:child_group, :parent => @third_group) # child group with displayable questions
      @second_child_group = Factory(:child_group, :name => 'second child', :parent => @fifth_group) # child group without displayable questions
      @first_question = Factory(:first_question, :group => @first_group)
      @second_question = Factory(:second_question, :group => @second_group)
      @third_question = Factory(:third_question, :group => @child_group)
      @fourth_question = Factory(:fourth_question, :group => @sixth_group)
    end
    
    it "should get all the parent groups for navigation" do
      groups = QuestionGroup.parent_groups
      groups.length.should == 4
    end
    
    it "should get the list of nav parents" do
      @session = { :situation => {} }
      groups = QuestionGroup.nav_parent_groups @session[:situation]
      groups.length.should == 5
    end
    
    it "should have at least one more question that needs to be displayed for particular group" do
      @session = { :situation => {} }
      @first_group.more_questions_to_display?(@session[:situation]).should == true
    end
    
    it "should have at least one more question that needs to be displayed for particular group with some questions already displayed" do
      @session = { :situation => { :groups => { @first_group.name => {
        :id => @first_group.id,
        :questions => { @first_question.name => { :answer => @first_question.default_answer, :accepted => true } }
      }}}}
      @second_group.more_questions_to_display?(@session[:situation]).should == true
    end
    
    it "should have at least one more question that needs to be displayed for all groups" do
      @session = { :situation => {} }
      QuestionGroup.more_questions_to_display?(@session[:situation]).should == true
    end
    
    it "should have at least one more question that needs to be displayed for all groups with some questions already displayed" do
      @session = { :situation => { :groups => { @first_group.name => {
        :id => @first_group.id,
        :questions => { @first_question.name => { :answer => @first_question.default_answer, :accepted => true } }
      }}}}
      QuestionGroup.more_questions_to_display?(@session[:situation]).should == true
    end
    
    it "should not have any more question to display" do
      @session = { :situation => { :groups => {}}}
      @session[:situation][:groups][@first_group.name] = {
        :id => @first_group.id,
        :questions => { @first_question.name => { :answer => @first_question.default_answer, :accepted => true } }
      }
      @session[:situation][:groups][@second_group.name] = {
        :id => @second_group.id,
        :questions => { @second_question.name => { :answer => @second_question.default_answer, :accepted => true } }
      }
      @session[:situation][:groups][@child_group.name] = {
        :id => @child_group.id,
        :questions => { @third_question.name => { :answer => @third_question.default_answer, :accepted => true } }
      }
      QuestionGroup.more_questions_to_display?(@session[:situation]).should == false
    end
  end
end
