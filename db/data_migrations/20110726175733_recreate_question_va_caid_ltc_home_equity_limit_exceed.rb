class RecreateQuestionVaCaidLtcHomeEquityLimitExceed < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  
      
    #   48	82.03	Do you have a home and property that has an equity value of over ~VA_RateCaidLtcHomeEquityLimit~ ?	VA_CaidLtcHomeEquityLimitExceed			YES:NO		NO	IF VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES OR VA_CaidSpouseInstitutionServicesApply= YES OR VA_CaidSpouseWaiverServicesApply = YES 	no	NO	Individuals who are applying for Long Term Care (LTC -- Waiver Services or Institutional Care) have since 2006 a high equity value limit on their home and the property it's on.  See M1460.150 & M1480.015 for the rules.	87.06
   
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
         @VA_CaidLtcHomeEquityLimitExceed = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLtcHomeEquityLimitExceed']) 
   
        if @VA_CaidLtcHomeEquityLimitExceed.blank? then
           @VA_CaidLtcHomeEquityLimitExceed = Question.new(:name => 'VA_CaidLtcHomeEquityLimitExceed', :text => 'VA_CaidLtcHomeEquityLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.03',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 7, :group_id => @QuestionGroup.id) 
        end
   
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:text, "Do you have a home and property that has an equity value over ~, the Ltc Home Equity Limit?") 
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:default_answer, "No")
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:question_type, "select") 
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:question_order, "7")
        @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:workbook_order, "87.06") 
   
       # IF VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES OR VA_CaidSpouseInstitutionServicesApply= YES OR VA_CaidSpouseWaiverServicesApply = YES 
          
       @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:display_rules, "
         VA_CaidInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidInstitutionServicesApply')
         VA_CaidWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidWaiverServicesApply')
         VA_CaidSpouseInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidSpouseInstitutionServicesApply')
         VA_CaidSpouseWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidSpouseWaiverServicesApply')
         (VA_CaidInstitutionServicesApply == 'Yes'  || VA_CaidWaiverServicesApply == 'Yes'  || VA_CaidSpouseInstitutionServicesApply == 'Yes' || VA_CaidSpouseWaiverServicesApply == 'Yes')")
   
        # calc to insert
        @VA_RateCaidLtcHomeEquityLimit  = WebCalc.find_by_name('VA_RateCaidLtcHomeEquityLimit')
   
        unless @VA_RateCaidLtcHomeEquityLimit.blank?
   
           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @VA_CaidLtcHomeEquityLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @VA_CaidLtcHomeEquityLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @VA_RateCaidLtcHomeEquityLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @VA_CaidLtcHomeEquityLimitExceed.id) 
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @VA_RateCaidLtcHomeEquityLimit.id) 
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end
         end
  end

  def self.down
  end
end
