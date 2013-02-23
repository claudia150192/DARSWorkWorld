class CreatePassAmtAllowableAnswerWebcalc < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  

    #    26 31	155	What monthly amount are you including in a PASS?  (You are making employability investments of $EmployInvestAmt. You may also be able to include work expenses not already counted as IRWE or BWE.)	
    #PassAmt			Zero or Positive Number =< EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt	You can not enter a monthly PASS amount greater than the total amount of work expenses and employability investments you have after subtracting any money you have already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION:  Smaller of (EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) OR ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt))	IF SsiGet = Y AND ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0))	Appear	200.00	I removed the restriction on Allowable Answers that prevented users from entering amounts greater than the income they had available to put in a PASS.  That allows us to give them a TEXT RESULT that informs them that they are exceeding that amount.	161.00
    

        @RPassAmtAllowableAnswer = WebCalc.find_by_name('RPassAmtAllowableAnswer')
        if @RPassAmtAllowableAnswer.blank? then
           @RPassAmtAllowableAnswer  = WebCalc.new(:name => 'RPassAmtAllowableAnswer')
        end

        @RPassAmtAllowableAnswer.operation = "
       EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt')
       DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
       EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
       OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
       SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
       BweAmt = manager.get_answer_by_question_name('BweAmt')
       EmployInvestAmt.to_f + DisWorkExpAmt.to_f + EstEarnTaxAmt.to_f + OthWorkExpAmt.to_f - SsiCaidIrweAmt.to_f - BweAmt.to_f
       "
        @RPassAmtAllowableAnswer.save!
  end

  def self.down
  end
end
