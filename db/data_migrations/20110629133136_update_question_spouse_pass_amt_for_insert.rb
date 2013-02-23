class UpdateQuestionSpousePassAmtForInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #29 31 33	156	How much of the $SpouseEmployInvestAmt your spouse is spending or setting aside monthly to improve future financial self sufficiency is your spouse including in a PASS? (It may also be possible to include work expenses not already counted as IRWE or BWE.)	
       #SpousePassAmt			Zero or Positive Number <= SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt	You can not enter a monthly PASS amount greater than the total amount of work expenses and employability investments your spouse has after subtracting any money already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION: Smaller of (SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) OR (SsdiAmtSelfFull + SsdiAmtOtherFull + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt + UnearnAmt + SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt+ SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt + InKindPMVAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt)	IF SpouseSsiGet = Y AND ((SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt) > 0))	Appear	0.00		162.00
       
      #SpousePassAmt question edit to add insert marker
      @SpousePassAmt = Question.find(:first, :conditions => ['name = ?',  'SpousePassAmt']) 
      @SpousePassAmt.update_attribute(:text, "How much of the ~ your spouse is spending or setting aside monthly to improve future financial self sufficiency is your spouse including in a PASS? (It may also be possible to include work expenses not already counted as IRWE or BWE.)") 
 
     # calc to insert
     @RSpouseEmployInvestAmt  = WebCalc.find_by_name('RSpouseEmployInvestAmt')
 
     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpousePassAmt.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SpousePassAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseEmployInvestAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SpousePassAmt.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseEmployInvestAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
         
  end

  def self.down
  end
end
