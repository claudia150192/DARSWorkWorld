class UpdateQuestionVaCaidWaiverServicesApplyDisplayRule < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'

    #old    #47	35.4	Are you applying for Home and Community-based Care (CBC) Waiver Services?	
           #VA_CaidWaiverServicesApply			YES:NO		NO	If State = Virginia AND CaidApply = Y AND VA_CaidApplyCoveredGroup <> (QMB OR SLMB OR QI OR QWDI)) AND VA_CaidInstitutionServicesApply <> Y	Appear	YES		33.40
    #new
    #47 49	35.4	Are you applying for Home and Community-based Care (CBC) Waiver Services?	VA_CaidWaiverServicesApply			YES:NO		NO	If State = Virginia AND (CaidGet = Y OR CaidApply = YES) AND ((VA_CaidGetCoveredGroup OR VA_CaidApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) AND VA_CaidWaiverServicesGet <> YES AND VA_CaidInstitutionServicesApply <> YES	no			33.40
    
    #      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
          @VA_CaidWaiverServicesApply = Question.find(:first, :conditions => ['name = ?',  'VA_CaidWaiverServicesApply']) 

    #    if @VA_CaidWaiverServicesApply.blank? then
    #       @VA_CaidWaiverServicesApply = Question.new(:name => 'VA_CaidWaiverServicesApply', :text => 'VA_CaidWaiverServicesApply?', :display_rules => 'always', :default_answer => 'No', :reference_id => '35.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 8 , :group_id => @QuestionGroup.id) 
    #    end
    #
    #    @VA_CaidWaiverServicesApply.update_attribute(:text, "Are you applying for Home and Community-based Care (CBC) Waiver Services?") 
    #    @VA_CaidWaiverServicesApply.update_attribute(:default_answer, "No")
    #    @VA_CaidWaiverServicesApply.update_attribute(:group_id, @QuestionGroup.id) 
    #    @VA_CaidWaiverServicesApply.update_attribute(:question_type, "select") 
    #    @VA_CaidWaiverServicesApply.update_attribute(:answer_choices, "Yes, No") 
    #    @VA_CaidWaiverServicesApply.update_attribute(:question_order, "8")
    #    @VA_CaidWaiverServicesApply.update_attribute(:workbook_order, "33.4") 

          #If State = Virginia AND (CaidGet = Y OR CaidApply = YES) 
          #AND ((VA_CaidGetCoveredGroup OR VA_CaidApplyCoveredGroup) <> (QMB OR SLMB OR QI OR QDWI)) AND VA_CaidWaiverServicesGet <> YES AND VA_CaidInstitutionServicesApply <> YES
          
          @VA_CaidWaiverServicesApply.update_attribute(:display_rules, "
          State = manager.get_answer_by_question_name('State')
          CaidGet = manager.get_answer_by_question_name('CaidGet')
          CaidApply = manager.get_answer_by_question_name('CaidApply')
          VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
          VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
          VA_CaidWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidWaiverServicesGet')
          VA_CaidInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidInstitutionServicesApply')
          State == 'Virginia' && (CaidGet == 'Yes' || CaidApply == 'Yes' ) && 
          VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'QDWI'  &&
          VA_CaidApplyCoveredGroup != 'QMB' && VA_CaidApplyCoveredGroup != 'SLMB' && VA_CaidApplyCoveredGroup != 'QI' && VA_CaidApplyCoveredGroup != 'QDWI'  &&
          VA_CaidWaiverServicesGet != 'Yes' && VA_CaidInstitutionServicesApply != 'Yes'") unless @VA_CaidWaiverServicesApply.blank?
  end

  def self.down
  end
end
