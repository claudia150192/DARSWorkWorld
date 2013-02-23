class UpdateQuestionSsiResourceLimitExceedForInsert < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
     #first Question Insert SsiResourceLimitExceed
     #Do you have countable resources that exceed the <RateSsiResourceLimit> SSI resource limit? (Do not count resources included in a PASS)
    #SsiResourceLimitExceed question edit
     
     @SsiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'SsiResourceLimitExceed']) 
    #@SsiResourceLimitExceed = Question.find_by_name('SsiResourceLimitExceed')
    @SsiResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ SSI resource limit? (Do not count resources included in a PASS)") 
    #could make this more robust for now we will assume a succesful find

   # insert
   @RateSsiResourceLimit  = WebCalc.find_by_name('RateSsiResourceLimit')

   @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SsiResourceLimitExceed.id, 1])
   if @Insert2.blank? then
      @Insert2  = QuestionInsert.new(:question_id => @SsiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateSsiResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:question_id, @SsiResourceLimitExceed.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateSsiResourceLimit.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
    
  end

  def self.down
  end
end
