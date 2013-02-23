class UpdateQuestionUserIsCaidCommunitySpouseDisplayRule < ActiveRecord::Migration
  def self.up
    
    #45 49	56.5	Are you considered for Medicaid purposes to be a "community spouse"?	UserIsCaidCommunitySpouse			YES:NO		NO	If Married = Y AND (VA_CaidSpouseInstitutionServicesGet = Y OR VA_CaidSpouseWaiverServicesGet = Y OR VA_CaidSpouseInstitutionServicesApply = Y OR VA_CaidSpouseWaiverServicesApply = Y)	Appear	YES	If spouse is applying for Long Term Care (Medical Institution or Waiver), then the resources of a Community Spouse are considered when determining initial eligibility.	57.50
        @UserIsCaidCommunitySpouse = Question.find(:first, :conditions => ['name = ?',  'UserIsCaidCommunitySpouse']) 

   #     If Married = Y AND (VA_CaidSpouseInstitutionServicesGet = Y OR VA_CaidSpouseWaiverServicesGet = Y OR VA_CaidSpouseInstitutionServicesApply = Y OR VA_CaidSpouseWaiverServicesApply = Y)
   
    @UserIsCaidCommunitySpouse.update_attribute(:display_rules, "
    State = manager.get_answer_by_question_name('State')
    Married = manager.get_answer_by_question_name('Married')
    VA_CaidSpouseInstitutionServicesGet = manager.get_answer_by_question_name('VA_CaidSpouseInstitutionServicesGet')
    VA_CaidSpouseWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidSpouseWaiverServicesGet')
    VA_CaidSpouseInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidSpouseInstitutionServicesApply')
    VA_CaidSpouseWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidSpouseWaiverServicesApply')
    (State == 'Virginia' && Married == 'Yes' && (VA_CaidSpouseInstitutionServicesGet == 'Yes' || VA_CaidSpouseWaiverServicesGet == 'Yes' || 
    VA_CaidSpouseInstitutionServicesApply == 'Yes' || VA_CaidSpouseWaiverServicesApply == 'Yes'))") unless @UserIsCaidCommunitySpouse.blank?
  end

  def self.down
  end
end
