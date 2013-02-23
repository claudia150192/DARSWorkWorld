require 'spec_helper'
require 'ruby-debug'
describe Question do
  describe "#create" do
    before(:each) do
      @valid_attributes = {
        :name => "value for name",
        :text => "value for text",
        :display_rules => "true",
        :default_answer => "value for default_answer",
        :reference_id => "value for reference_id",
        :workbook_order => "value for reference_id",
        :question_order => 2,
        :question_type => "value for reference_id",
        :group_id => Factory(:question_group),
        :validation_rules => ""
      }
      @invalid_attributes = {
        :name => "",
        :text => "",
        :display_rules => "",
        :default_answer => "",
        :reference_id => ""
      }
    end

    it "should set default what_if_text to the question text" do
      q = Question.create!(@valid_attributes)
      q.what_if_text.should==q.text
    end

    it "should create a new instance given valid attributes" do
      Question.create!(@valid_attributes)
    end
    
    it "should require a name" do
      @question = Question.new(@invalid_attribues)
      @question.should have(1).errors_on(:name)
    end
    
    it "should require a text" do
      @question = Question.new(@invalid_attribues)
      @question.should have(1).errors_on(:text)
    end
    
    it "should require display rules" do
      @question = Question.new(@invalid_attribues)
      @question.should have(2).errors_on(:display_rules)
    end
    
    it "should require a group" do
      @question = Question.new(@invalid_attribues)
      @question.should have(1).errors_on(:group_id)
    end
    
    it "should require a question type" do
      @question = Question.new(@invalid_attribues)
      @question.should have(1).errors_on(:question_type)
    end
    
    it "should require an order" do
      @question = Question.new(@invalid_attribues)
      @question.should have(1).errors_on(:question_order)
    end
  end
  
  describe "#display rules validation" do
    before(:each) do
      @group = Factory(:question_group)
      @question = Factory(:question, :group => @group)
    end
    
    it "should validate when display rules is 'always'" do
      @question.display_rules = "always"
      @question.should have(0).errors_on(:display_rules)
    end
    
    it "should validate when display rules is true" do
      @question.display_rules = "true"
      @question.should have(0).errors_on(:display_rules)
    end
    
    it "should validate when display rules is false" do
      @question.display_rules = "false"
      @question.should have(0).errors_on(:display_rules)
    end
    
    it "should not validate when display rules is neither false nor true" do
      @question.display_rules = "something else"
      @question.should have(1).errors_on(:display_rules)
    end
    
    it "should not validate when display rules is ''" do
      @question.display_rules = ""
      @question.should have(2).errors_on(:display_rules)
    end
    
    it "should validate with equality expression" do
      @question.display_rules = "self.name == 'question'"
      @question.should have(0).errors_on(:display_rules)
    end
    
    it "should validate with ruby code block" do
      @question.display_rules = "if (name == 'question') then true else false end"
      @question.should have(0).errors_on(:display_rules)
    end
  end
  
  describe "#showing question based on display rules" do
    before(:each) do
      @group = Factory(:question_group)
      @question = Factory(:question, :group => @group)
    end
    
    it "should display when display rules is 'always'" do
      @question.display_rules = "always"
      @question.show?.should == true
    end
    
    it "should display when display rules is true" do
      @question.display_rules = "true"
      @question.show?.should == true
    end
    
    it "should not display when display rules is false" do
      @question.display_rules = "false"
      @question.show?.should == false
    end
    
    it "should display with equality expression" do
      @question.display_rules = "self.name == 'question'"
      @question.show?.should == true
    end
    
    it "should display with ruby code block" do
      @question.display_rules = "if (name == 'question') then true else false end"
      @question.show?.should == true
    end
  end
  
  describe "#answer validation" do
    describe "#valid answers" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:valid_question, :group => @group)
        @session = {}
        @session = { :situation => {:groups => { @group.name => {} }}}
        @session[:situation][:groups][@group.name] = { :questions => { 
          @question.name => 200
        } }
      end
    
      it "should validate" do
        @question.validates?(@session[:situation][:groups][@group.name]).should be_true
      end
      
      it "should not have errors" do
        @question.has_validation_errors?.should be_false
      end
    end
    
    describe "#invalid answers" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:question, :group => @group)
        @session = {}
        @session = { :situation => {:groups => { @group.name => {} }}}
        @session[:situation][:groups][@group.name] = { :questions => { 
          @question.name => "text"
        } }
      end
      
      it "should not have errors before validation check" do
        @question.has_validation_errors?.should be_false
      end
      
      it "should not validate" do
        @question.validates?(@session[:situation][:groups][@group.name]).should be_false
      end
      
      it "should have errors after validation check" do
        @question.validates?(@session[:situation][:groups][@group.name])
        @question.has_validation_errors?.should be_true
      end
    end
  end
  
  describe "#default answers" do
    describe "#expressions" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:expression_default_question, :group => @group)
      end
      
      it "should not have errors on expression field" do
        @question.should have(0).errors_on(:default_answer)
      end
      
      it "should have errors on bad expression field" do
        @question.default_answer = "expression= blah"
        @question.should have(1).errors_on(:default_answer)
      end
      
      it "should check if default is an expression" do
        @question.is_expression?(:default_answer).should == true
      end
      
      it "should return the  expression" do
        @question.expression(:default_answer).should == " 1 + 2"
      end
      
      it "should evalutate the expression" do
         @question.eval_expression(:default_answer).should == 3
      end
    end

    describe "#default_answer_for" do
      before(:each) do
        @group = Factory(:question_group)
        @question = Factory(:question, :group => @group)
        @user = Factory(:user)
        @case = Factory(:case, :user=>@user)
        @parent = Factory(:situation, :case=>@case, :completed=>true)
        @whatif = Factory(:what_if, :case=>@case, :parent=>@parent)
        @answer = Factory(:answer, :question=>@question, :situation=>@parent, :answer=>"what I said")
      end

      it "should return the question default answer if situation is null" do
        default = @question.default_answer_for nil
        default.should == @question.default_answer
      end

      it "should return the question default answer if the situation parent is null" do
        default = @question.default_answer_for @parent
        default.should == @question.default_answer
      end

      it "should returnt he parent answers if the situation parent is not null" do
        default = @question.default_answer_for @whatif
        default.should == @answer.answer
      end

      it "should return the question's default answer the situation has a parent but the question is marked to not allow override" do
        sitname = Factory(:question, :name=>"SitName", :group=> @group, :default_answer=>"What if #1", :force_default=>true)
        answer = Factory(:answer, :question=>sitname, :situation=>@parent, :answer=>"My real problem")
        default = sitname.default_answer_for @whatif
        default.should == sitname.default_answer
      end
    end
  end
end
