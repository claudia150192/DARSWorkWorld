class CreateQuestionVaCaidSpouseInstitutionServicesGet < ActiveRecord::Migration
  def self.up
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])
   
    #48	54.2	Does your spouse receive Institutional Care Medicaid Services?	VA_CaidSpouseInstitutionServicesGet			YES:NO		NO	If State = Virginia AND CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup <> (QMB OR SLMB OR QI OR QDWI) AND (LiveWithSpouseInFacility = Y OR SpouseLiveInFacility = Y) AND VA_SpouseLiveInAuxGrantFacility <> Y AND VA_LiveWithSpouseAuxGrantFacility <> Y	no		Most Medicaid covered groups will cover Waiver and institutional Services.  See M1460.200.	55.20
    
   
    @VA_CaidSpouseInstitutionServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseInstitutionServicesApply']) 

   if @VA_CaidSpouseInstitutionServicesApply.blank? then
      @VA_CaidSpouseInstitutionServicesApply = Question.new(:name => 'VA_CaidSpouseInstitutionServicesApply', :text => 'VA_CaidSpouseInstitutionServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '54.2',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
   end
  
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:text, "Does your spouse receive Institutional Care Medicaid Services?") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:default_answer, "No")
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:question_type, "select") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:answer_choices, "Yes, No") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:question_order, "3")
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:workbook_order, "54.20") 

    #If State = Virginia AND CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup <> (QMB OR SLMB OR QI OR QDWI) AND (LiveWithSpouseInFacility = Y OR SpouseLiveInFacility = Y) 
    # AND VA_SpouseLiveInAuxGrantFacility <> Y AND VA_LiveWithSpouseAuxGrantFacility <> Y
     
    
    @VA_CaidSpouseInstitutionServicesApply.update_attribute(:display_rules, "
    State = manager.get_answer_by_question_name('State')
    CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
    VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
    LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
    SpouseLiveInFacility = manager.get_answer_by_question_name('SpouseLiveInFacility')
    VA_SpouseLiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_SpouseLiveInAuxGrantFacility')
    VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
    (State == 'Virginia' && CaidSpouseGet == 'Yes' &&
    VA_CaidSpouseGetCoveredGroup != 'QMB' && VA_CaidSpouseGetCoveredGroup != 'SLMB' && VA_CaidSpouseGetCoveredGroup != 'QI' && VA_CaidSpouseGetCoveredGroup != 'QDWI'  &&
    (LiveWithSpouseInFacility == 'Yes' || SpouseLiveInFacility == 'Yes') && VA_SpouseLiveInAuxGrantFacility != 'Yes' && VA_LiveWithSpouseAuxGrantFacility != 'Yes')")
  end

  def self.down
  end
end
