class RecreateQuestionVaCaidSpouseOrChildLivesInHome < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    
  #  48	82.04	Do any of the following live in your home: you or your spouse, a dependent child, or your adult blind or disabled child?	
  #VA_CaidSpouseOrChildLivesInHome					NO	IF VA_CaidLtcHomeEquityLimitExceed = YES	no		The LTC home equity limit does not apply if a spouse, depenent child or disabled adult child lives in the home.  See M1460.150 & M1480.015 for the rules.	87.08
  
 
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @VA_CaidSpouseOrChildLivesInHome = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseOrChildLivesInHome']) 
 
      if @VA_CaidSpouseOrChildLivesInHome.blank? then
         @VA_CaidSpouseOrChildLivesInHome = Question.new(:name => 'VA_CaidSpouseOrChildLivesInHome', :text => 'VA_CaidSpouseOrChildLivesInHome?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.04',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 8, :group_id => @QuestionGroup.id) 
      end
 
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:text, "Do any of the following live in your home: you or your spouse, a dependent child, or your adult blind or disabled child?") 
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:default_answer, "No")
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:group_id, @QuestionGroup.id) 
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:question_type, "select") 
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:answer_choices, "Yes, No") 
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:question_order, "8")
      @VA_CaidSpouseOrChildLivesInHome.update_attribute(:workbook_order, "87.08") 
 
     #  IF VA_CaidLtcHomeEquityLimitExceed = YES
             
     @VA_CaidSpouseOrChildLivesInHome.update_attribute(:display_rules, "
       VA_CaidLtcHomeEquityLimitExceed = manager.get_answer_by_question_name('VA_CaidLtcHomeEquityLimitExceed')
       (VA_CaidLtcHomeEquityLimitExceed == 'Yes')")
    
    
  end

  def self.down
  end
end
