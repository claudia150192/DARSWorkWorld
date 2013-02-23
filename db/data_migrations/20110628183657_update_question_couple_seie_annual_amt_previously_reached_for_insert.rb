class UpdateQuestionCoupleSeieAnnualAmtPreviouslyReachedForInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #27	142	You and your spouse have no SEIE excluded income. Have you and/or your spouse already excluded in this calendar year enough earned income to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	
       #CoupleSeieAnnualAmtPreviouslyReached			YES:NO		YES	IF Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt = 0 AND SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt > 0	no		Appear when a student and spouse who are otherwise eligible for SEIE do not get the exclusion.  It will trigger an Alert about using the SEIE unless the annual amount has been used up.  It is tricky because it must come up even if user is not a student or user is a student without earnings, or if spouse does not get SSI (but deems income to user).	148.00
      
      #Per Web
      #CoupleSeieAnnualAmtPreviouslyReached 	
      #You and your spouse have no SEIE excluded income. Have you and/or your spouse already excluded in this calendar year enough earned income to reach the maximum annual SEIE limit? 	
      #Student = manager.get_answer_by_question_name('Student') 
      #SpouseStudent = manager.get_answer_by_question_name('SpouseStudent') 
      #SeieAmt = manager.get_answer_by_question_name('SeieAmt') if SeieAmt != nil then SeieAmt = Float(SeieAmt) else SeieAmt = 0 end SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt') if SpouseSeieAmt != nil then SpouseSeieAmt = Float(SpouseSeieAmt) else SpouseSeieAmt = 0 end SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt') if SsiOrCaidEarnAmt != nil then SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt) else SsiOrCaidEarnAmt = 0 end SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt') if SpouseWhoIsDeemedEarnAmt != nil then SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt) else SpouseWhoIsDeemedEarnAmt = 0 end SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt') if SpouseSsiOrCaidEarnAmt != nil then SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt) else SpouseSsiOrCaidEarnAmt = 0 end (Student == 'Yes' && SpouseStudent = 'Yes') && ((SeieAmt + SpouseSeieAmt) == 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > 0) 	142 	Student Earned Income Exclusion (SEIE) 	select 	Yes, No 	Yes 	9 				148.0 
       
      #CoupleSeieAnnualAmtPreviouslyReached question edit to add insert marker
      @CoupleSeieAnnualAmtPreviouslyReached = Question.find(:first, :conditions => ['name = ?',  'CoupleSeieAnnualAmtPreviouslyReached']) 
      @CoupleSeieAnnualAmtPreviouslyReached.update_attribute(:text, "You and your spouse have no SEIE excluded income. Have you and/or your spouse already excluded in this calendar year enough earned income to reach the maximum annual SEIE limit (~)?") 
    
     # calc to insert 
     @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')
    
     @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieAnnualAmtPreviouslyReached.id, 1])
     if @Insert1.blank? then
        @Insert1  = QuestionInsert.new(:question_id => @CoupleSeieAnnualAmtPreviouslyReached.id, :insert_number => '1', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:question_id, @CoupleSeieAnnualAmtPreviouslyReached.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end
       
  end

  def self.down
  end
end
