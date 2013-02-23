class CreateQuestionVaSpouseLiveInAuxGrantFacility < ActiveRecord::Migration
  def self.up
    #Add new VA_SpouseLiveInAuxGrantFacility question from workbook 46
     #45	51.5	Does your spouse live in a facility or foster care supported by an Auxiliary Grant?	VA_SpouseLiveInAuxGrantFacility			YES:NO		NO	If SpouseLiveInFacility = Y AND State = VA
     
     @QuestionGroup_Spouse_SSI = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse SSI'])
     @VA_SpouseLiveInAuxGrantFacility = Question.find(:first, :conditions => ['name = ?',  'VA_SpouseLiveInAuxGrantFacility']) 

     if @VA_SpouseLiveInAuxGrantFacility.blank? then
        @VA_SpouseLiveInAuxGrantFacility = Question.new(:name => 'VA_SpouseLiveInAuxGrantFacility', :text => 'VA_SpouseLiveInAuxGrantFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '51.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 2 , :group_id => @QuestionGroup_Spouse_SSI.id) 
     end
     
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:text, "Does your spouse live in a facility or foster care supported by an Auxiliary Grant?") 
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:default_answer, "No")
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:group_id, @QuestionGroup_Spouse_SSI.id) 
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:question_type, "select") 
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:answer_choices, "Yes, No") 
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:question_order, "2")
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:reference_id, "51.5") 
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:workbook_order, "52.25") 
#BaH, NEED to remember to change all the question order for all  household_info questions

    # If SpouseLiveInFacility = Y AND State = VA
       @VA_SpouseLiveInAuxGrantFacility.update_attribute(:display_rules, "
     SpouseLiveInFacility = manager.get_answer_by_question_name('SpouseLiveInFacility')
     State = manager.get_answer_by_question_name('State')
     (SpouseLiveInFacility == 'Yes' && State == 'Virginia')")
  end

  def self.down
  end
end
