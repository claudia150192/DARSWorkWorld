class CreateQuestionVaLiveWithSpouseAuxGrantFacility < ActiveRecord::Migration
  def self.up
    
    #29 45	20	Do you and your spouse live in a facility or foster care supported by an Auxiliary Grant?	VA_LiveWithSpouseAuxGrantFacility			YES:NO		NO	IF LiveWithSpouseInFacility = Y AND State = VA	no			28.60
    
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSI'])
      @VA_LiveWithSpouseAuxGrantFacility = Question.find(:first, :conditions => ['name = ?',  'VA_LiveWithSpouseAuxGrantFacility']) 

     if @VA_LiveWithSpouseAuxGrantFacility.blank? then
        @VA_LiveWithSpouseAuxGrantFacility = Question.new(:name => 'VA_LiveWithSpouseAuxGrantFacility', :text => 'VA_LiveWithSpouseAuxGrantFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '20',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 5 , :group_id => @QuestionGroup.id) 
     end

     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:text, "Do you and your spouse live in a facility or foster care supported by an Auxiliary Grant?") 
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:default_answer, "No")
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:group_id, @QuestionGroup.id) 
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:question_type, "select") 
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:answer_choices, "Yes, No") 
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:question_order, "5")
     @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:workbook_order, "28.60") 

      # IF LiveWithSpouseInFacility = Y AND State = VA
    @VA_LiveWithSpouseAuxGrantFacility.update_attribute(:display_rules, "
      LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
      State = manager.get_answer_by_question_name('State')
      (LiveWithSpouseInFacility == 'Yes' && State == 'Virginia')")
  end

  def self.down
  end
end
