class DeleteOrphan240836QuestionInQuestionInsert < ActiveRecord::Migration
  def self.up
    
      #Well i don't remember deleting this question.  I don't know the name of the question that had this number but i don't know wy its worth looking now
      @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ?',  240836])
       if !(@Insert1.blank?) then
            @Insert1.delete
        end

  end

  def self.down
  end
end
