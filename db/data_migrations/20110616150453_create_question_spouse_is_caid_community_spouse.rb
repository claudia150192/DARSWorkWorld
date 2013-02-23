class CreateQuestionSpouseIsCaidCommunitySpouse < ActiveRecord::Migration
  def self.up
    #Add new SpouseIsCaidCommunitySpouse question from workbook 46
     #29 45	27	Is your spouse considered for Medicaid purposes to be a "community spouse"?	SpouseIsCaidCommunitySpouse			YES:NO		NO	IF (VA_CaidApplyCoveredGroup = Medical Institution OR Waiver) AND  Married = Y AND LiveWithSpouseInFacility <> Y AND SpouseLiveInFacility <> Y
     #this is a bit of a misnomer sine we are actually renaming a question and moving it from Household info VA_CaidLiveInFacilitySpouseInCommunity
     
     @QuestionGroup_Medicaid = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
     @SpouseIsCaidCommunitySpouse = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLiveInFacilitySpouseInCommunity']) 

      if @SpouseIsCaidCommunitySpouse.blank? then
         @SpouseIsCaidCommunitySpouse = Question.new(:name => 'SpouseIsCaidCommunitySpouse', :text => 'SpouseIsCaidCommunitySpouse?', :display_rules => 'always', :default_answer => 'No', :reference_id => '27',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 5 , :group_id => @QuestionGroup_Medicaid.id) 
      end
     
     @SpouseIsCaidCommunitySpouse.update_attribute(:name, 'SpouseIsCaidCommunitySpouse') 
      @SpouseIsCaidCommunitySpouse.update_attribute(:text, 'Is your spouse considered for Medicaid purposes to be a "community spouse"?') 
      @SpouseIsCaidCommunitySpouse.update_attribute(:default_answer, "No")
      @SpouseIsCaidCommunitySpouse.update_attribute(:group_id, @QuestionGroup_Medicaid.id) 
      @SpouseIsCaidCommunitySpouse.update_attribute(:question_type, "select") 
      @SpouseIsCaidCommunitySpouse.update_attribute(:answer_choices, "Yes, No") 
      @SpouseIsCaidCommunitySpouse.update_attribute(:question_order, "5")
      @SpouseIsCaidCommunitySpouse.update_attribute(:reference_id, "27") 
      @SpouseIsCaidCommunitySpouse.update_attribute(:workbook_order, "33.5") 
#BaH, NEED to remember to change all the question order for all household_info questions

    # IF (VA_CaidApplyCoveredGroup = Medical Institution OR Waiver) AND  Married = Y AND LiveWithSpouseInFacility <> Y AND SpouseLiveInFacility <> Y
     @SpouseIsCaidCommunitySpouse.update_attribute(:display_rules, "
     VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
     Married = manager.get_answer_by_question_name('Married')
     LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
     SpouseLiveInFacility = manager.get_answer_by_question_name('SpouseLiveInFacility')
     ((VA_CaidApplyCoveredGroup == 'Medical Institution' || VA_CaidApplyCoveredGroup == 'Waiver' ) && Married == 'Yes' && LiveWithSpouseInFacility != 'Yes' && SpouseLiveInFacility != 'Yes')")
  end

  def self.down
  end
end
