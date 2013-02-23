class CreateQuestionUserIsCaidCommunitySpouse < ActiveRecord::Migration
  def self.up
   #Add new UserIsCaidCommunitySpouse question from workbook 46
    #45	56.5	Are you considered for Medicaid purposes to be a "community spouse"?	UserIsCaidCommunitySpouse			YES:NO		NO	IF VA_CaidSpouseApplyCoveredGroup = (Medical Instition OR Waiver) AND (LiveWithSpouseInFacility <> Y AND LiveInFacility <> Y) 
    
    
    @QuestionGroup_Spouse_SSI = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse SSI'])
    @UserIsCaidCommunitySpouse = Question.find(:first, :conditions => ['name = ?',  'UserIsCaidCommunitySpouse']) 

    if @UserIsCaidCommunitySpouse.blank? then
       @UserIsCaidCommunitySpouse = Question.new(:name => 'UserIsCaidCommunitySpouse', :text => 'UserIsCaidCommunitySpouse?', :display_rules => 'always', :default_answer => 'No', :reference_id => '51.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 2 , :group_id => @QuestionGroup_Spouse_SSI.id) 
    end
    
     @UserIsCaidCommunitySpouse.update_attribute(:text, 'Are you considered for Medicaid purposes to be a "community spouse"?') 
     @UserIsCaidCommunitySpouse.update_attribute(:default_answer, "No")
     @UserIsCaidCommunitySpouse.update_attribute(:group_id, @QuestionGroup_Spouse_SSI.id) 
     @UserIsCaidCommunitySpouse.update_attribute(:question_type, "select") 
     @UserIsCaidCommunitySpouse.update_attribute(:answer_choices, "Yes, No") 
     @UserIsCaidCommunitySpouse.update_attribute(:question_order, "2")
     @UserIsCaidCommunitySpouse.update_attribute(:reference_id, "51.5") 
     @UserIsCaidCommunitySpouse.update_attribute(:workbook_order, "52.25") 
#BaH, NEED to remember to change all the question order for all  household_info questions
#stopping here for the day.  Need to decide how to deal with this display rule since it refers to a question[s?] that either does not exit or whose name has changed


    # IF VA_CaidSpouseApplyCoveredGroup = (Medical Instition OR Waiver) AND (LiveWithSpouseInFacility <> Y AND LiveInFacility <> Y) 
     @UserIsCaidCommunitySpouse.update_attribute(:display_rules, "
     VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
     LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
     LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
     
     ((VA_CaidSpouseApplyCoveredGroup == 'Medical Instition' || VA_CaidSpouseApplyCoveredGroup == 'Waiver') && (LiveWithSpouseInFacility != 'Yes' && LiveInFacility != 'Yes'))")
  end

  def self.down
  end
end
