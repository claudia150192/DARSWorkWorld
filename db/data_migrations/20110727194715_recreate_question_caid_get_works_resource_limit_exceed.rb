class RecreateQuestionCaidGetWorksResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
 
    #40 41 45 50	82.5	Do you have countable resources that exceed the ~VA_RateCaidWorksResourceLimit~ resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)	
    #CaidGetWorksResourceLimitExceed			YES:NO		NO	If ((CaidGet = Y AND VA_CaidGetCoveredGroup = MEDICAID WORKS)	no		This question is for those who have enrolled in MEDICAID WORKS. Those who are applying must meet the regular Medicaid limits for individual or couple.  Once enrolled, the individual is treated as an individual for the resources kept in a WIN account.	87.55
    
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
      @CaidGetWorksResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidGetWorksResourceLimitExceed']) 
 
      
      if @CaidGetWorksResourceLimitExceed.blank? then
         @CaidGetWorksResourceLimitExceed = Question.new(:name => 'CaidGetWorksResourceLimitExceed', :text => 'CaidGetWorksResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 15, :group_id => @QuestionGroup.id) 
      end
 
      @CaidGetWorksResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)") 
      @CaidGetWorksResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidGetWorksResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidGetWorksResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidGetWorksResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidGetWorksResourceLimitExceed.update_attribute(:question_order, "15")
      @CaidGetWorksResourceLimitExceed.update_attribute(:workbook_order, "87.55") 
 
     #    If ((CaidGet = Y AND VA_CaidGetCoveredGroup = MEDICAID WORKS)
       @CaidGetWorksResourceLimitExceed.update_attribute(:display_rules, "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        (CaidGet == 'Yes' && VA_CaidGetCoveredGroup == 'MEDICAID WORKS')")
    
        # calc to insert
         @VA_RateCaidWorksResourceLimit  = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')
    
      unless @VA_RateCaidWorksResourceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidGetWorksResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidGetWorksResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @VA_RateCaidWorksResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidGetWorksResourceLimitExceed.id) 
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @VA_RateCaidWorksResourceLimit.id) 
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
       end
  end

  def self.down
  end
end
