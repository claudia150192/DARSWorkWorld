class UpdateQuestionLiveWithSpouseInFacility < ActiveRecord::Migration
  def self.up
    #replace a couple live-in [including removing the metion of funding options] 
    #looks like 1 question has replaced 2 VA_LiveWithSpouseAuxGrantFacility  VA_CaidLiveWithSpouseInFacility replaced by LiveWithSpouseInFacility
    
     #29 45	21	Do you and your spouse live in an assisted living facility, a group home, an institution or foster care?	LiveWithSpouseInFacility			YES:NO		NO	IF LiveWithSpouseAndOthers = Y	no
   
     @QuestionGroup_Household_Info = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
   
     @VA_CaidLiveWithSpouseInFacility = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLiveWithSpouseInFacility']) 

     if !(@VA_CaidLiveWithSpouseInFacility.blank?) then
        @VA_CaidLiveWithSpouseInFacility.delete
     end
    
     @LiveWithSpouseInFacility = Question.find(:first, :conditions => ['name = ?',  'VA_LiveWithSpouseAuxGrantFacility']) 

      if @LiveWithSpouseInFacility.blank? then
         @LiveWithSpouseInFacility = Question.new(:name => 'LiveWithSpouseInFacility', :text => 'LiveWithSpouseInFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '21',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 10 , :group_id => @QuestionGroup_Household_Info.id) 
      end
     
     @LiveWithSpouseInFacility.update_attribute(:name, "LiveWithSpouseInFacility") 
     @LiveWithSpouseInFacility.update_attribute(:text, "Do you and your spouse live in an assisted living facility, a group home, an institution or foster care?") 
     @LiveWithSpouseInFacility.update_attribute(:default_answer, "No")
     @LiveWithSpouseInFacility.update_attribute(:group_id, @QuestionGroup_Household_Info.id) 
     @LiveWithSpouseInFacility.update_attribute(:question_type, "select") 
     @LiveWithSpouseInFacility.update_attribute(:answer_choices, "Yes, No") 
     @LiveWithSpouseInFacility.update_attribute(:question_order, "10")
     @LiveWithSpouseInFacility.update_attribute(:reference_id, "21") 
     @LiveWithSpouseInFacility.update_attribute(:workbook_order, "19") 
#BaH, NEED to remember to change all the question order for all household_info questions

    # IF LiveWithSpouseAndOthers = Y
  @LiveWithSpouseInFacility.update_attribute(:display_rules, "
   LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
   (LiveWithSpouseAndOthers == 'Yes')")
  end

  def self.down
  end
end
