class RecreateQuestionCaidApplyLtcCommunitySpousePraExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
 
    #  48 49	82.42	Does your spouse have countable resources that exceed your spouse's Protected Resource Amount (PRA)?	
    #   CaidApplyLtcCommunitySpousePraExceed			YES:NO		NO	If (VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES ) AND SpouseIsCaidCommunitySpouse = YES)	no		See M1480.232.  A TIP should tell user how PRA is established and that it is used only in the application process.  After eligibility is established, only the individual's resources are counted.	87.45
  
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @CaidApplyLtcCommunitySpousePraExceed = Question.find(:first, :conditions => ['name = ?',  'CaidApplyLtcCommunitySpousePraExceed']) 
 
      if @CaidApplyLtcCommunitySpousePraExceed.blank? then
         @CaidApplyLtcCommunitySpousePraExceed = Question.new(:name => 'CaidApplyLtcCommunitySpousePraExceed', :text => 'CaidApplyLtcCommunitySpousePraExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.42',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 13, :group_id => @QuestionGroup.id) 
      end
 
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:text, "Does your spouse have countable resources that exceed your spouse's Protected Resource Amount (PRA)?") 
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:default_answer, "No")
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:question_type, "select") 
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:question_order, "13")
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:workbook_order, "87.45") 
 
     #   If (VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES ) AND SpouseIsCaidCommunitySpouse = YES)
      @CaidApplyLtcCommunitySpousePraExceed.update_attribute(:display_rules, "
        VA_CaidInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidInstitutionServicesApply')
        VA_CaidWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidWaiverServicesApply')
        SpouseIsCaidCommunitySpouse = manager.get_answer_by_question_name('SpouseIsCaidCommunitySpouse')
       ((VA_CaidInstitutionServicesApply == 'Yes' || VA_CaidWaiverServicesApply == 'Yes' ) && SpouseIsCaidCommunitySpouse == 'Yes')")
     
  end

  def self.down
  end
end
