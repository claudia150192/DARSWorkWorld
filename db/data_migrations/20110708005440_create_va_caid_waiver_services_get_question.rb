class CreateVaCaidWaiverServicesGetQuestion < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
    
     #47	33.4	Do you receive Home and Community-based Care (CBC) Waiver Services?	VA_CaidWaiverServicesGet			YES:NO		NO	If State = Virginia AND CaidGet = Y AND VA_CaidGetCoveredGroup <> (QMB OR SLMB OR QI OR QWDI) AND LiveWithSpouseInFacility <> Y AND LiveInFacility <> Y	no			31.40
     
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
        @VA_CaidWaiverServicesGet = Question.find(:first, :conditions => ['name = ?',  'VA_CaidWaiverServicesGet']) 

       if @VA_CaidWaiverServicesGet.blank? then
          @VA_CaidWaiverServicesGet = Question.new(:name => 'VA_CaidWaiverServicesGet', :text => 'VA_CaidWaiverServicesGet?', :display_rules => 'always', :default_answer => 'No', :reference_id => '33.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 4 , :group_id => @QuestionGroup.id) 
       end

       @VA_CaidWaiverServicesGet.update_attribute(:text, "Do you receive Home and Community-based Care (CBC) Waiver Services?") 
       @VA_CaidWaiverServicesGet.update_attribute(:default_answer, "No")
       @VA_CaidWaiverServicesGet.update_attribute(:group_id, @QuestionGroup.id) 
       @VA_CaidWaiverServicesGet.update_attribute(:question_type, "select") 
       @VA_CaidWaiverServicesGet.update_attribute(:answer_choices, "Yes, No") 
       @VA_CaidWaiverServicesGet.update_attribute(:question_order, "4")
       @VA_CaidWaiverServicesGet.update_attribute(:workbook_order, "31.4") 
      
        #If State = Virginia AND CaidGet = Y AND VA_CaidGetCoveredGroup <> (QMB OR SLMB OR QI OR QWDI) AND LiveWithSpouseInFacility <> Y AND LiveInFacility <> Y
        @VA_CaidWaiverServicesGet.update_attribute(:display_rules, "
        State = manager.get_answer_by_question_name('State')
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
        LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
        State == 'Virginia' && CaidGet == 'Yes' && VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'QDWI'  &&
        LiveWithSpouseInFacility != 'Yes' &&  LiveInFacility != 'Yes'")
  end

  def self.down
  end
end
