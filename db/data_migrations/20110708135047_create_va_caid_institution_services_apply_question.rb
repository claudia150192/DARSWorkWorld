class CreateVaCaidInstitutionServicesApplyQuestion < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
    
     #47	35.2	Are you applying for Institutional care Medicaid Services?	
     #VA_CaidInstitutionServicesApply			YES:NO		NO	If State = Virginia AND (CaidGet = Y OR CaidApply = Y) AND ((VA_CaidGetCoveredGroup OR VA_CaidApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QWDI))	Appear	NO		33.20
     
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
        @VA_CaidInstitutionServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidInstitutionServicesApply']) 

       if @VA_CaidInstitutionServicesApply.blank? then
          @VA_CaidInstitutionServicesApply = Question.new(:name => 'VA_CaidInstitutionServicesApply', :text => 'VA_CaidInstitutionServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '35.2',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 7 , :group_id => @QuestionGroup.id) 
       end

       @VA_CaidInstitutionServicesApply.update_attribute(:text, "Are you applying for Institutional Care Medicaid Services?") 
       @VA_CaidInstitutionServicesApply.update_attribute(:default_answer, "No")
       @VA_CaidInstitutionServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
       @VA_CaidInstitutionServicesApply.update_attribute(:question_type, "select") 
       @VA_CaidInstitutionServicesApply.update_attribute(:answer_choices, "Yes, No") 
       @VA_CaidInstitutionServicesApply.update_attribute(:question_order, "7")
       @VA_CaidInstitutionServicesApply.update_attribute(:workbook_order, "33.2") 
      
        #If State = Virginia AND (CaidGet = Y OR CaidApply = Y) AND ((VA_CaidGetCoveredGroup OR VA_CaidApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QWDI))
        #Bob's guess add VA_CaidInstitutionServicesGet and no to the live-in questions 
        @VA_CaidInstitutionServicesApply.update_attribute(:display_rules, "
        State = manager.get_answer_by_question_name('State')
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
        LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
        VA_CaidInstitutionServicesGet = manager.get_answer_by_question_name('VA_CaidInstitutionServicesGet')
        State == 'Virginia' && (CaidGet == 'Yes' || CaidApply == 'Yes') && VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'QDWI'  &&
        VA_CaidApplyCoveredGroup != 'QMB' && VA_CaidApplyCoveredGroup != 'SLMB' && VA_CaidApplyCoveredGroup != 'QI' && VA_CaidApplyCoveredGroup != 'QDWI'  &&
        LiveWithSpouseInFacility != 'Yes' &&  LiveInFacility != 'Yes' && VA_CaidInstitutionServicesGet != 'Yes'")
  end

  def self.down
  end
end
