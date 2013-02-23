class CreateVaCaidInstitutionServicesGetQuestion < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'
    
     #47	33.2	Do you receive Institutional care Medicaid Services?	
     #VA_CaidInstitutionServicesGet			YES:NO		NO	If State = Virginia AND CaidGet = Y AND VA_CaidGetCoveredGroup <> (QMB OR SLMB OR QI OR QWDI) AND (LiveWithSpouseInFacility = Y OR LiveInFacility = Y) AND VA_LiveInAuxGrantFacility <> Y AND VA_LiveWithSpouseAuxGrantFacility <> Y	no		Most Medicaid covered groups will cover Waiver and institutional Services.  See M1460.200.	31.20
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
        @VA_CaidInstitutionServicesGet = Question.find(:first, :conditions => ['name = ?',  'VA_CaidInstitutionServicesGet']) 

       if @VA_CaidInstitutionServicesGet.blank? then
          @VA_CaidInstitutionServicesGet = Question.new(:name => 'VA_CaidInstitutionServicesGet', :text => 'VA_CaidInstitutionServicesGet?', :display_rules => 'always', :default_answer => 'No', :reference_id => '33.2',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
       end

       @VA_CaidInstitutionServicesGet.update_attribute(:text, "Do you receive Institutional Care Medicaid Services?") 
       @VA_CaidInstitutionServicesGet.update_attribute(:default_answer, "No")
       @VA_CaidInstitutionServicesGet.update_attribute(:group_id, @QuestionGroup.id) 
       @VA_CaidInstitutionServicesGet.update_attribute(:question_type, "select") 
       @VA_CaidInstitutionServicesGet.update_attribute(:answer_choices, "Yes, No") 
       @VA_CaidInstitutionServicesGet.update_attribute(:question_order, "3")
       @VA_CaidInstitutionServicesGet.update_attribute(:workbook_order, "31.2") 
      
        # If State = Virginia AND CaidGet = Y AND VA_CaidGetCoveredGroup <> (QMB OR SLMB OR QI OR QWDI) AND (LiveWithSpouseInFacility = Y OR LiveInFacility = Y) AND VA_LiveInAuxGrantFacility <> Y AND VA_LiveWithSpouseAuxGrantFacility <> Y
        @VA_CaidInstitutionServicesGet.update_attribute(:display_rules, "
        State = manager.get_answer_by_question_name('State')
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
        LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
        VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
        VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
        State == 'Virginia' && CaidGet == 'Yes' && VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'QDWI'  &&
        (LiveWithSpouseInFacility == 'Yes' ||  LiveInFacility == 'Yes') && VA_LiveInAuxGrantFacility != 'Yes' && VA_LiveWithSpouseAuxGrantFacility != 'Yes'")
       
  end

  def self.down
  end
end
