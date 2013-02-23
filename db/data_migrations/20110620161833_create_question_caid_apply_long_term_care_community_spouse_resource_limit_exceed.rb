class CreateQuestionCaidApplyLongTermCareCommunitySpouseResourceLimitExceed < ActiveRecord::Migration
  def self.up


   require 'wwweb_session_manager' 
   
   # 45	82.45	Does your spouse have countable resources that exceed the Protected Resource Amount (PRA), and if so do the excess resources plus your own resources exceed the <RateCaidMostGroupsResourceLimit> resource limit?	CaidApplyLongTermCareCommunitySpouseResourceLimitExceed			YES:NO		NO	If (VA_CaidApplyCoveredGroup = Medical Institution AND SpouseIsCaidCommunitySpouse = YES) OR (VA_CaidApplyCoveredGroup = Waiver AND LiveWithSpouse = YES)	no		See M1480.232.  A TIP should tell user how PRA is established and that it is used only in the application process.  After eligibility is established, only the individual's resources are counted.	87.50
   
   
     @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
      @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidApplyLongTermCareCommunitySpouseResourceLimitExceed']) 

     if @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.blank? then
        @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed = Question.new(:name => 'CaidApplyLongTermCareCommunitySpouseResourceLimitExceed', :text => 'CaidApplyLongTermCareCommunitySpouseResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.45',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 9 , :group_id => @QuestionGroup.id) 
     end

     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:text, "Does your spouse have countable resources that exceed the Protected Resource Amount (PRA), and if so do the excess resources plus your own resources exceed the ~ resource limit?") 
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:default_answer, "No")
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:question_type, "select") 
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:question_order, "9")
     @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:workbook_order, "87.50") 

      # If (VA_CaidApplyCoveredGroup = Medical Institution AND SpouseIsCaidCommunitySpouse = YES) OR (VA_CaidApplyCoveredGroup = Waiver AND LiveWithSpouse = YES)
      
    @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.update_attribute(:display_rules, "
      VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
      SpouseIsCaidCommunitySpouse = manager.get_answer_by_question_name('SpouseIsCaidCommunitySpouse')
      VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
      LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
      ((VA_CaidApplyCoveredGroup == 'Medical Institution' && SpouseIsCaidCommunitySpouse == 'Yes') || (VA_CaidApplyCoveredGroup == 'Waiver' && LiveWithSpouse == 'Yes')) ")
  
  #note this webcalc is referring to a rate that needs to be fixed in the rate table, name has changed
      
       #This is not the best way to add a new calc but i forgot this calc does not exist yet
         @RateCaidMostGroupsResourceLimit = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')
         if @RateCaidMostGroupsResourceLimit.blank? then
           @RateCaidMostGroupsResourceLimit  = WebCalc.new(:name => 'RateCaidMostGroupsResourceLimit')
         end

          @RateCaidMostGroupsResourceLimit.operation = "
          unless manager.get_answer_by_question_name('SitDate').blank? 
         SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
                 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
                RateCaidMostGroupsResourceLimit = rate.RateCaidMostGroupsResourceLimit
            else
               RateCaidMostGroupsResourceLimit =  2000
            end
           "
           @RateCaidMostGroupsResourceLimit.save!
      
       # calc to insert
       @RateCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')

       @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.id, 1])
       if @Insert2.blank? then
          @Insert2  = QuestionInsert.new(:question_id => @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert2.save!
      else
        @Insert2.update_attribute(:question_id, @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.id)
        @Insert2.update_attribute(:insert_number, '1')
        @Insert2.update_attribute(:webcalc_id_to_insert, @RateCaidMostGroupsResourceLimit.id)
        @Insert2.update_attribute(:insert_marker, '~')
        @Insert2.update_attribute(:insert_type, 'currency')
       end
    
  end

  def self.down
  end
end
