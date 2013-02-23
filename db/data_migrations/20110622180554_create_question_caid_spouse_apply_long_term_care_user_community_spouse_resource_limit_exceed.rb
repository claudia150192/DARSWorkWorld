class CreateQuestionCaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager' 

      #45	82.7	Do you have countable resources that exceed the Protected Resource Amount (PRA), and if so do the excess resources plus your spouse's resources exceed the <RateCaidMostGroupsResourceLimit> resource limit?	
      #CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = Different AND ((VA_CaidSpouseApplyCoveredGroup = Medical Institution AND UserIsCaidCommunitySpouse = YES) OR (VA_CaidSpouseApplyCoveredGroup = Waiver AND UserIsCaidCommunitySpouse = YES))	no			87.75
       

         @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
          @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed']) 

         if @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.blank? then
            @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed = Question.new(:name => 'CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed', :text => 'CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.7',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 14 , :group_id => @QuestionGroup.id) 
         end

         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the Protected Resource Amount (PRA), and if so do the excess resources plus your spouse's resources exceed the ~ resource limit?") 
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:default_answer, "No")
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:question_type, "select") 
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:question_order, "14")
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:workbook_order, "87.75") 

        @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.update_attribute(:display_rules, "
        R_VA_CaidUserSpouseSameCovGroup =  'this needs an edit, talked to DR on June 21'
        R_VA_CaidUserSpouseSameCovGroup == 'this needs an edit, talked to DR on June 21'")

        #this should be found
          @RateCaidMostGroupsResourceLimit = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')

 #     #this has been added so should not execute I'm a bit leery changing this often used calc here
 #       if @RateCaidMostGroupsResourceLimit.blank? then
 #         @RateCaidMostGroupsResourceLimit  = WebCalc.new(:name => 'RateCaidMostGroupsResourceLimit')
 #       end
 #
 #      @RateCaidMostGroupsResourceLimit.operation = "
 #       unless manager.get_answer_by_question_name('SitDate').blank? 
 #      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 #              rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
 #             RateCaidMostGroupsResourceLimit = rate.RateCaidMostGroupsResourceLimit
 #         else
 #            RateCaidMostGroupsResourceLimit =  6000
 #         end
 #      "
 #         @RateCaidMostGroupsResourceLimit.save!

        # calc to insert
        @RateCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')

        @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.id, 1])
        if @Insert2.blank? then
           @Insert2  = QuestionInsert.new(:question_id => @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert2.save!
       else
         @Insert2.update_attribute(:question_id, @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.id)
         @Insert2.update_attribute(:insert_number, '1')
         @Insert2.update_attribute(:webcalc_id_to_insert, @RateCaidMostGroupsResourceLimit.id)
         @Insert2.update_attribute(:insert_marker, '~')
         @Insert2.update_attribute(:insert_type, 'currency')
        end
    
  end

  def self.down
  end
end
