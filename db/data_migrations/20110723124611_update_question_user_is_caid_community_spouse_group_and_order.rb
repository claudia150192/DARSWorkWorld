class UpdateQuestionUserIsCaidCommunitySpouseGroupAndOrder < ActiveRecord::Migration
  def self.up
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])
    @UserIsCaidCommunitySpouse = Question.find(:first, :conditions => ['name = ?',  'UserIsCaidCommunitySpouse']) 

  #  if @UserIsCaidCommunitySpouse.blank? then
  #     @UserIsCaidCommunitySpouse = Question.new(:name => 'UserIsCaidCommunitySpouse', :text => 'UserIsCaidCommunitySpouse?', :display_rules => 'always', :default_answer => 'No', :reference_id => '51.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 2 , :group_id => @QuestionGroup_Spouse_SSI.id) 
  #  end
    
   #  @UserIsCaidCommunitySpouse.update_attribute(:text, 'Are you considered for Medicaid purposes to be a "community spouse"?') 
  #   @UserIsCaidCommunitySpouse.update_attribute(:default_answer, "No")
     @UserIsCaidCommunitySpouse.update_attribute(:group_id, @QuestionGroup.id) unless @UserIsCaidCommunitySpouse.blank? || @QuestionGroup.blank?
    # @UserIsCaidCommunitySpouse.update_attribute(:question_type, "select") 
   #  @UserIsCaidCommunitySpouse.update_attribute(:answer_choices, "Yes, No") 
     @UserIsCaidCommunitySpouse.update_attribute(:question_order, "9") unless @UserIsCaidCommunitySpouse.blank?
    # @UserIsCaidCommunitySpouse.update_attribute(:reference_id, "51.5") 
    # @UserIsCaidCommunitySpouse.update_attribute(:workbook_order, "52.25")
  end

  def self.down
  end
end