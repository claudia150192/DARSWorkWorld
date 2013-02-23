class CreateQuestionVaCaidSpouseWaiverServicesApply < ActiveRecord::Migration
  def self.up
    
     @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])

      #48 49	56.3	Is your spouse applying for Home and Community-based Care (CBC) Waiver Services?	VA_CaidSpouseWaiverServicesApply			YES:NO		NO	If State = VA AND (CaidSpouseGet = YES OR CaidSpouseApply = YES) AND ((VA_CaidSpouseGetCoveredGroup OR VA_CaidSpouseApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) AND VA_CaidSpouseWaiverServicesGet <> YES AND VA_CaidSpouseInstitutionServicesApply <> YES	no			57.30

      @VA_CaidSpouseWaiverServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseWaiverServicesApply']) 

     if @VA_CaidSpouseWaiverServicesApply.blank? then
        @VA_CaidSpouseWaiverServicesApply = Question.new(:name => 'VA_CaidSpouseWaiverServicesApply', :text => 'VA_CaidSpouseWaiverServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '56.3',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 8 , :group_id => @QuestionGroup.id) 
     end

     @VA_CaidSpouseWaiverServicesApply.update_attribute(:text, "Is your spouse applying for Home and Community-based Care (CBC) Waiver Services?") 
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:default_answer, "No")
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:question_type, "select") 
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:answer_choices, "Yes, No") 
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:question_order, "8")
     @VA_CaidSpouseWaiverServicesApply.update_attribute(:workbook_order, "57.30") 

      #If State = VA AND (CaidSpouseGet = YES OR CaidSpouseApply = YES) AND ((VA_CaidSpouseGetCoveredGroup OR VA_CaidSpouseApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) 
      #AND VA_CaidSpouseWaiverServicesGet <> YES AND VA_CaidSpouseInstitutionServicesApply <> YES
      
      @VA_CaidSpouseWaiverServicesApply.update_attribute(:display_rules, "
      State = manager.get_answer_by_question_name('State')
      CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
      CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
      VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
      VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
      VA_CaidSpouseWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidSpouseWaiverServicesGet')
      VA_CaidSpouseInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidSpouseInstitutionServicesApply')
      (State == 'Virginia' && (CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') &&
      VA_CaidSpouseGetCoveredGroup != 'QMB' && VA_CaidSpouseGetCoveredGroup != 'SLMB' && VA_CaidSpouseGetCoveredGroup != 'QI' && VA_CaidSpouseGetCoveredGroup != 'QDWI'  &&
      VA_CaidSpouseApplyCoveredGroup != 'QMB' && VA_CaidSpouseApplyCoveredGroup != 'SLMB' && VA_CaidSpouseApplyCoveredGroup != 'QI' && VA_CaidSpouseApplyCoveredGroup != 'QDWI'  &&
      VA_CaidSpouseWaiverServicesGet != 'Yes' && VA_CaidSpouseInstitutionServicesApply != 'Yes')")
      
  end

  def self.down
  end
end
