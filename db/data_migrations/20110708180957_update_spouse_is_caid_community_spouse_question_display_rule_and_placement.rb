class UpdateSpouseIsCaidCommunitySpouseQuestionDisplayRuleAndPlacement < ActiveRecord::Migration
  def self.up
   # 29 45 47	27	Is your spouse considered for Medicaid purposes to be a "community spouse"?	
   #SpouseIsCaidCommunitySpouse			YES:NO		NO	If Married = Y AND (VA_CaidInstitutionServicesGet = Y OR VA_CaidWaiverServicesGet = Y OR VA_CaidInstitutionServicesApply = Y OR VA_CaidWaiverServicesApply = Y)	no		If user is in a facility or gets a waiver, then the spouse is considered a "commuity spouse" unless the spouse is in a facility.  A spouse who is on a waiver can be (strangely) a community spouse.  (See M1480.010 B.2.)	33.50
    
    require 'wwweb_session_manager'  
    
    #If Married = Y AND (VA_CaidInstitutionServicesGet = Y OR VA_CaidWaiverServicesGet = Y OR VA_CaidInstitutionServicesApply = Y OR VA_CaidWaiverServicesApply = Y)
    
      @SpouseIsCaidCommunitySpouse = Question.find(:first, :conditions => ['name = ?',  'SpouseIsCaidCommunitySpouse']) 
      @SpouseIsCaidCommunitySpouse.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      VA_CaidInstitutionServicesGet = manager.get_answer_by_question_name('VA_CaidInstitutionServicesGet')
      VA_CaidWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidWaiverServicesGet')
      VA_CaidInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidInstitutionServicesApply')
      VA_CaidWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidWaiverServicesApply')
      (Married == 'Yes' && (VA_CaidInstitutionServicesGet == 'Yes' || VA_CaidWaiverServicesGet == 'Yes' || VA_CaidInstitutionServicesApply == 'Yes' || VA_CaidWaiverServicesApply == 'Yes'))
      ")
      
      @SpouseIsCaidCommunitySpouse.update_attribute(:question_order, "9")
  end

  def self.down
  end
end
