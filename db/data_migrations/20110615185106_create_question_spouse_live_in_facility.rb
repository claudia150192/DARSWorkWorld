class CreateQuestionSpouseLiveInFacility < ActiveRecord::Migration
  def self.up
    #Add new SpouseLiveInFacility question from workbook 46
     #45	21.4	Does your spouse  live in an assisted living facility, a group home, an institution or foster care?	SpouseLiveInFacility			YES:NO		NO	IF Married = Y AND LiveWithSpouse = N
     @QuestionGroup_Household_Info = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
     @SpouseLiveInFacility = Question.find(:first, :conditions => ['name = ?',  'SpouseLiveInFacility']) 

      if @SpouseLiveInFacility.blank? then
         @SpouseLiveInFacility = Question.new(:name => 'SpouseLiveInFacility', :text => 'SpouseLiveInFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '21.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 11 , :group_id => @QuestionGroup_Household_Info.id) 
      end
     
      @SpouseLiveInFacility.update_attribute(:text, "Does your spouse live in an assisted living facility, a group home, an institution or foster care?") 
      @SpouseLiveInFacility.update_attribute(:default_answer, "No")
      @SpouseLiveInFacility.update_attribute(:group_id, @QuestionGroup_Household_Info.id) 
      @SpouseLiveInFacility.update_attribute(:question_type, "select") 
      @SpouseLiveInFacility.update_attribute(:answer_choices, "Yes, No") 
      @SpouseLiveInFacility.update_attribute(:question_order, "11")
      @SpouseLiveInFacility.update_attribute(:reference_id, "21.4") 
      @SpouseLiveInFacility.update_attribute(:workbook_order, "19.5") 
#BaH, NEED to remember to change all the question order for all household_info questions

    # IF Married = Y AND LiveWithSpouse = N
       @SpouseLiveInFacility.update_attribute(:display_rules, "
     Married = manager.get_answer_by_question_name('Married')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
     (Married == 'Yes' && LiveWithSpouse == 'No')")
  end

  def self.down
  end
end
