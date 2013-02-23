class CreateQSpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
           require 'wwweb_session_manager'  

    #THis calc is used inside SpouseSeieAmt question as an insert into text
    #Ques 136 How much of your spouse's monthly earnings (SpouseSsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt) are excluded as a Student Earned Income Exclusion (SEIE)?


   @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
   if @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.blank? then
      @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt  = WebCalc.new(:name => 'Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
   end
 
     @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.operation = "
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt') 
    SpouseSsiOrCaidEarnAmt.to_f + SpouseWhoIsDeemedEarnAmt.to_f
   "
   @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.save!
    
  end

  def self.down
  end
end
