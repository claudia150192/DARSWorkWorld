class DeleteOrphan240856QuestionInQuestionInsert < ActiveRecord::Migration
  def self.up
    
    #ok, bad carma, i deleted a question without first looking at insert table
    @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ?',  240856])
     if !(@Insert1.blank?) then
          @Insert1.delete
      end
      
      
  end

  def self.down
  end
end
