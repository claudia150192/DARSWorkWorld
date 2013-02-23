class CreateVaCaidWaiverServicesApplyQuestion < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
    
     #47	35.4	Are you applying for Home and Community-based Care (CBC) Waiver Services?	
     #VA_CaidWaiverServicesApply			YES:NO		NO	If State = Virginia AND CaidApply = Y AND VA_CaidApplyCoveredGroup <> (QMB OR SLMB OR QI OR QWDI)) AND VA_CaidInstitutionServicesApply <> Y	Appear	YES		33.40
          
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
        @VA_CaidWaiverServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidWaiverServicesApply']) 

       if @VA_CaidWaiverServicesApply.blank? then
          @VA_CaidWaiverServicesApply = Question.new(:name => 'VA_CaidWaiverServicesApply', :text => 'VA_CaidWaiverServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '35.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 8 , :group_id => @QuestionGroup.id) 
       end

       @VA_CaidWaiverServicesApply.update_attribute(:text, "Are you applying for Home and Community-based Care (CBC) Waiver Services?") 
       @VA_CaidWaiverServicesApply.update_attribute(:default_answer, "No")
       @VA_CaidWaiverServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
       @VA_CaidWaiverServicesApply.update_attribute(:question_type, "select") 
       @VA_CaidWaiverServicesApply.update_attribute(:answer_choices, "Yes, No") 
       @VA_CaidWaiverServicesApply.update_attribute(:question_order, "8")
       @VA_CaidWaiverServicesApply.update_attribute(:workbook_order, "33.4") 
      
        #If State = Virginia AND CaidApply = Y AND VA_CaidApplyCoveredGroup <> (QMB OR SLMB OR QI OR QWDI)) AND VA_CaidInstitutionServicesApply <> Y
        #well this is possible but suspect.  have a question in for Ruth  I stole the get variant display rule until further notice
        @VA_CaidWaiverServicesApply.update_attribute(:display_rules, "
        State = manager.get_answer_by_question_name('State')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
        LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
        VA_CaidWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidWaiverServicesGet')
        State == 'Virginia' && CaidApply == 'Yes' && VA_CaidApplyCoveredGroup != 'QMB' && VA_CaidApplyCoveredGroup != 'SLMB' && VA_CaidApplyCoveredGroup != 'QI' && VA_CaidApplyCoveredGroup != 'QDWI'  &&
        LiveWithSpouseInFacility != 'Yes' &&  LiveInFacility != 'Yes'  &&  VA_CaidWaiverServicesGet != 'Yes'")
  end

  def self.down
  end
end
