class UpdateQuestionSeieLessThanSeieMaxAnnualLmtReachedForInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #25	138	Your SEIE exclusion ($SeieAmt) is less than the SEIE Monthly Maximum Exclusion ($RateSEIEMaxMonthly).  Have you used up your SEIE annual exclusion amount ($6600)?	SeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt >RateSEIEMaxMonthly  AND SeieAmt < RateSEIEMaxMonthly	no			144.00
                               
      #SeieLessThanSeieMaxAnnualLmtReached question edit to add insert marker
      @SeieLessThanSeieMaxAnnualLmtReached = Question.find(:first, :conditions => ['name = ?',  'SeieLessThanSeieMaxAnnualLmtReached']) 
      @SeieLessThanSeieMaxAnnualLmtReached.update_attribute(:text, "Your SEIE exclusion (~) is less than the SEIE Monthly Maximum Exclusion (~).  Have you used up your SEIE annual exclusion amount (~)?") 
      
     # calc to insert First of 3 inserts
     @Q_SeieAmt  = WebCalc.find_by_name('Q_SeieAmt')

     @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanSeieMaxAnnualLmtReached.id, 1])
     if @Insert1.blank? then
        @Insert1  = QuestionInsert.new(:question_id => @SeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:question_id, @SeieLessThanSeieMaxAnnualLmtReached.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SeieAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end
     
     # calc to insert 2nd of 3 inserts
      @RateSEIEMaxMonthly  = WebCalc.find_by_name('RateSEIEMaxMonthly')

      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanSeieMaxAnnualLmtReached.id, 2])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @SeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '2', :webcalc_id_to_insert => @RateSEIEMaxMonthly.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @SeieLessThanSeieMaxAnnualLmtReached.id)
       @Insert2.update_attribute(:insert_number, '2')
       @Insert2.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxMonthly.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
      
      # calc to insert 3rd of 3 inserts           RateSEIEMaxYear
        @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

        @Insert3 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanSeieMaxAnnualLmtReached.id, 3])
        if @Insert3.blank? then
           @Insert3  = QuestionInsert.new(:question_id => @SeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '3', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert3.save!
       else
         @Insert3.update_attribute(:question_id, @SeieLessThanSeieMaxAnnualLmtReached.id)
         @Insert3.update_attribute(:insert_number, '3')
         @Insert3.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
         @Insert3.update_attribute(:insert_marker, '~')
         @Insert3.update_attribute(:insert_type, 'currency')
        end
  end

  def self.down
  end
end
