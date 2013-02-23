class CreateQuestionVaCaidSpouseWaiverServicesGet < ActiveRecord::Migration
  def self.up
     @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])

      #48	54.4	Does your spouse receive Home and Community-based Care (CBC) Waiver Services?	VA_CaidSpouseWaiverServicesGet			YES:NO		NO	If State = Virginia AND CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup <> (QMB OR SLMB OR QI OR QDWI) AND LiveWithSpouseInFacility <> Y AND SpouseLiveInFacility <> Y	Appear	YES		55.40
      
      @VA_CaidSpouseWaiverServicesGet = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseWaiverServicesGet']) 

     if @VA_CaidSpouseWaiverServicesGet.blank? then
        @VA_CaidSpouseWaiverServicesGet = Question.new(:name => 'VA_CaidSpouseWaiverServicesGet', :text => 'VA_CaidSpouseWaiverServicesGet?', :display_rules => 'always', :default_answer => 'No', :reference_id => '54.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 4, :group_id => @QuestionGroup.id) 
     end

     @VA_CaidSpouseWaiverServicesGet.update_attribute(:text, "Does your spouse receive Home and Community-based Care (CBC) Waiver Services?") 
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:default_answer, "No")
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:group_id, @QuestionGroup.id) 
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:question_type, "select") 
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:answer_choices, "Yes, No") 
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:question_order, "4")
     @VA_CaidSpouseWaiverServicesGet.update_attribute(:workbook_order, "55.40") 

      #If State = Virginia AND CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup <> (QMB OR SLMB OR QI OR QDWI) AND LiveWithSpouseInFacility <> Y AND SpouseLiveInFacility <> Y
      
      @VA_CaidSpouseWaiverServicesGet.update_attribute(:display_rules, "
      State = manager.get_answer_by_question_name('State')
      CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
      VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
      LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
      SpouseLiveInFacility = manager.get_answer_by_question_name('SpouseLiveInFacility')
      VA_SpouseLiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_SpouseLiveInAuxGrantFacility')
      VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
      (State == 'Virginia' && CaidSpouseGet == 'Yes' &&
      VA_CaidSpouseGetCoveredGroup != 'QMB' && VA_CaidSpouseGetCoveredGroup != 'SLMB' && VA_CaidSpouseGetCoveredGroup != 'QI' && VA_CaidSpouseGetCoveredGroup != 'QDWI'  &&
      LiveWithSpouseInFacility != 'Yes' && SpouseLiveInFacility != 'Yes')")
  end

  def self.down
  end
end
