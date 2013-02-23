class CreateQuestionVaLiveInAuxGrantFacility < ActiveRecord::Migration
  def self.up
   
   # 29 45	25	Do you live in a facility or foster care supported by an Auxiliary Grant?	VA_LiveInAuxGrantFacility			YES:NO		NO	IF LiveInFacility = Y AND State = VA	no		Note that although Aux Grants are VA's SSI supplement, users can get Aux Grant even if they don't get SSI if they meet income criteria that are explained in the help topic overview of aux grants.	28.55
     
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSI'])
    @VA_LiveInAuxGrantFacility = Question.find(:first, :conditions => ['name = ?',  'VA_LiveInAuxGrantFacility']) 

   if @VA_LiveInAuxGrantFacility.blank? then
      @VA_LiveInAuxGrantFacility = Question.new(:name => 'VA_LiveInAuxGrantFacility', :text => 'VA_LiveInAuxGrantFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '25',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 4 , :group_id => @QuestionGroup.id) 
   end
  
   @VA_LiveInAuxGrantFacility.update_attribute(:text, "Do you live in a facility or foster care supported by an Auxiliary Grant?") 
   @VA_LiveInAuxGrantFacility.update_attribute(:default_answer, "No")
   @VA_LiveInAuxGrantFacility.update_attribute(:group_id, @QuestionGroup.id) 
   @VA_LiveInAuxGrantFacility.update_attribute(:question_type, "select") 
   @VA_LiveInAuxGrantFacility.update_attribute(:answer_choices, "Yes, No") 
   @VA_LiveInAuxGrantFacility.update_attribute(:question_order, "4")
   @VA_LiveInAuxGrantFacility.update_attribute(:workbook_order, "28.55") 

    # IF LiveInFacility = Y AND State = VA
    @VA_LiveInAuxGrantFacility.update_attribute(:display_rules, "
    LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
    State = manager.get_answer_by_question_name('State')
    (LiveInFacility == 'Yes' && State == 'Virginia')")
  end

  def self.down
  end
end
