class CreateQuestionVaCaidSpouseInstitutionServicesApply < ActiveRecord::Migration
  def self.up
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])
   
   # 48 49	56.2	Is your spouse applying for Institutional Care Medicaid Services?	VA_CaidSpouseInstitutionServicesApply			YES:NO		NO	If State = VA AND (CaidSpouseGet = YES OR CaidSpouseApply = YES) AND ((VA_CaidSpouseGetCoveredGroup OR VA_CaidSpouseApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) AND VA_CaidSpouseInstitutionServicesGet <> YES	Appear	NO		57.20
   
    @VA_CaidSpouseInstitutionServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseInstitutionServicesApply']) 

   if @VA_CaidSpouseInstitutionServicesApply.blank? then
      @VA_CaidSpouseInstitutionServicesApply = Question.new(:name => 'VA_CaidSpouseInstitutionServicesApply', :text => 'VA_CaidSpouseInstitutionServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '56.2',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 4 , :group_id => @QuestionGroup.id) 
   end
  
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:text, "Is your spouse applying for Institutional Care Medicaid Services?") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:default_answer, "No")
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:question_type, "select") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:answer_choices, "Yes, No") 
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:question_order, "7")
   @VA_CaidSpouseInstitutionServicesApply.update_attribute(:workbook_order, "57.20") 

    # If State = VA AND (CaidSpouseGet = YES OR CaidSpouseApply = YES) AND ((VA_CaidSpouseGetCoveredGroup OR VA_CaidSpouseApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) AND VA_CaidSpouseInstitutionServicesGet <> YES
    
    @VA_CaidSpouseInstitutionServicesApply.update_attribute(:display_rules, "
    State = manager.get_answer_by_question_name('State')
    CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
    CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
    VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
    VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
    VA_CaidSpouseInstitutionServicesGet = manager.get_answer_by_question_name('VA_CaidSpouseInstitutionServicesGet')
    (State == 'Virginia' && (CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') &&
    VA_CaidSpouseGetCoveredGroup != 'QMB' && VA_CaidSpouseGetCoveredGroup != 'SLMB' && VA_CaidSpouseGetCoveredGroup != 'QI' && VA_CaidSpouseGetCoveredGroup != 'QDWI'  &&
    VA_CaidSpouseApplyCoveredGroup != 'QMB' && VA_CaidSpouseApplyCoveredGroup != 'SLMB' && VA_CaidSpouseApplyCoveredGroup != 'QI' && VA_CaidSpouseApplyCoveredGroup != 'QDWI'  &&
    VA_CaidSpouseInstitutionServicesGet != 'Yes')")
  end

  def self.down
  end
end
