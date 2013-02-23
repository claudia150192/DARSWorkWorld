class UpdateQuestionSsiCoupleResourceLimitExceedForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     # SsiCoupleResourceLimitExceed
     #Do you and your spouse have countable resources that exceed the <RateCoupleSsiResourceLimit> SSI resource limit? (Do not count resources included in a PASS)
     
    #SsiCoupleResourceLimitExceed question edit to add insert marker
    @SsiCoupleResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'SsiCoupleResourceLimitExceed']) 
     @SsiCoupleResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ SSI resource limit? (Do not count resources included in a PASS)") 

   # calc to insert
   @RateCoupleSsiResourceLimit  = WebCalc.find_by_name('RateCoupleSsiResourceLimit')

   @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SsiCoupleResourceLimitExceed.id, 1])
   if @Insert2.blank? then
      @Insert2  = QuestionInsert.new(:question_id => @SsiCoupleResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleSsiResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:question_id, @SsiCoupleResourceLimitExceed.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateCoupleSsiResourceLimit.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
