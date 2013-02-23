class DeleteQuestionCaidApplyLongTermCareCommunitySpouseResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     
      #This question no longer exists with this name
       @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidApplyLongTermCareCommunitySpouseResourceLimitExceed']) 
     
      if !(@CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.blank?)  then
         @CaidApplyLongTermCareCommunitySpouseResourceLimitExceed.delete
      end
  end

  def self.down
  end
end
