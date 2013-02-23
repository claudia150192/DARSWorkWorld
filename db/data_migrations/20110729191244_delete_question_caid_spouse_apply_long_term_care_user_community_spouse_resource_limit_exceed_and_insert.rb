class DeleteQuestionCaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceedAndInsert < ActiveRecord::Migration
  def self.up
    #dealing with deleted question and associated insert
    
    @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed']) 
    
     @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.id, 1])
     if !(@Insert1.blank?) then
           @Insert1.delete
     end
    
      #This question no longer exists
      if !(@CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.blank?)  then
         @CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed.delete
      end
          
  end

  def self.down
  end
end
