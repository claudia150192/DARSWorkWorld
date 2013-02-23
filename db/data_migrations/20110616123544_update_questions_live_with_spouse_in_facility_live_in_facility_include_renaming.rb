class UpdateQuestionsLiveWithSpouseInFacilityLiveInFacilityIncludeRenaming < ActiveRecord::Migration
  def self.up
    #replace a couple live-in [including removing the metion of funding options] 
    #old VA_CaidLiveInFacility, VA_CaidLiveWithSpouseInFacility
    #new  LiveInFacility,LiveWithSpouseInFacility,
    #looks like 1 question has replaced 2 VA_CaidLiveInFacility  VA_LiveInAuxGrantFacility replaced by LiveInFacility
    
     #29 45	26	Do you live in an assisted living facility, a group home, an institution or foster care?	LiveInFacility			YES:NO		NO	IF LiveWithOthers = Y
     
     @QuestionGroup_Household_Info = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
   
     @VA_CaidLiveInFacility = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLiveInFacility']) 

     if !(@VA_CaidLiveInFacility.blank?) then
        @VA_CaidLiveInFacility.delete
     end
    
     @LiveInFacility = Question.find(:first, :conditions => ['name = ?',  'VA_LiveInAuxGrantFacility']) 

      if @LiveInFacility.blank? then
         @LiveInFacility = Question.new(:name => 'LiveInFacility', :text => 'LiveInFacility?', :display_rules => 'always', :default_answer => 'No', :reference_id => '26',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 15 , :group_id => @QuestionGroup_Household_Info.id) 
      end
     
     @LiveInFacility.update_attribute(:name, "LiveInFacility") 
     @LiveInFacility.update_attribute(:text, "Do you live in an assisted living facility, a group home, an institution or foster care?") 
     @LiveInFacility.update_attribute(:default_answer, "No")
     @LiveInFacility.update_attribute(:group_id, @QuestionGroup_Household_Info.id) 
     @LiveInFacility.update_attribute(:question_type, "select") 
     @LiveInFacility.update_attribute(:answer_choices, "Yes, No") 
     @LiveInFacility.update_attribute(:question_order, "15")
     @LiveInFacility.update_attribute(:reference_id, "26") 
     @LiveInFacility.update_attribute(:workbook_order, "24") 
#BaH, NEED to remember to change all the question order for all household_info questions

    # IF IF LiveWithOthers = Y
   @LiveInFacility.update_attribute(:display_rules, "
   LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
   (LiveWithOthers == 'Yes')")
  end

  def self.down
  end
end
