class UpdateQuestionPassAmtForInsert < ActiveRecord::Migration
  def self.up
  
     require 'wwweb_session_manager'  
        #26 31	155	What monthly amount are you including in a PASS?  (You are making employability investments of $EmployInvestAmt. You may also be able to include work expenses not already counted as IRWE or BWE.)	
        #PassAmt			Zero or Positive Number =< EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt	You can not enter a monthly PASS amount greater than the total amount of work expenses and employability investments you have after subtracting any money you have already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION:  Smaller of (EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) OR ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt))	IF SsiGet = Y AND ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0))	no	200.00	I removed the restriction on Allowable Answers that prevented users from entering amounts greater than the income they had available to put in a PASS.  That allows us to give them a TEXT RESULT that informs them that they are exceeding that amount.	161.00
        
       #PassAmt question edit to add insert marker
       @PassAmt = Question.find(:first, :conditions => ['name = ?',  'PassAmt']) 
       @PassAmt.update_attribute(:text, "What monthly amount are you including in a PASS?  (You are making employability investments of ~. You may also be able to include work expenses not already counted as IRWE or BWE.)") 
  
      # calc to insert
      @REmployInvestAmt  = WebCalc.find_by_name('REmployInvestAmt')
  
      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @PassAmt.id, 1])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @PassAmt.id, :insert_number => '1', :webcalc_id_to_insert => @REmployInvestAmt.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @PassAmt.id)
       @Insert2.update_attribute(:insert_number, '1')
       @Insert2.update_attribute(:webcalc_id_to_insert, @REmployInvestAmt.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
         
  end

  def self.down
  end
end
