class UpdateQuestionPassAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
           #26 31	155	What monthly amount are you including in a PASS?  (You are making employability investments of $EmployInvestAmt. You may also be able to include work expenses not already counted as IRWE or BWE.)	
           #PassAmt			Zero or Positive Number =< EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt	
           #You can not enter a monthly PASS amount greater than the total amount of work expenses and employability investments you have after subtracting any money you have already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION:  Smaller of (EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) OR ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt))	IF SsiGet = Y AND ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0))	Appear	200.00	I removed the restriction on Allowable Answers that prevented users from entering amounts greater than the income they had available to put in a PASS.  That allows us to give them a TEXT RESULT that informs them that they are exceeding that amount.	161.00
           
          #PassAmt question edit to add insert marker
          @PassAmt = Question.find(:first, :conditions => ['name = ?',  'PassAmt']) 

          @PassAmt.update_attribute(:validation_message, "You can not enter a monthly PASS amount greater than the total amount of work expenses and employability investments you have after subtracting any money you have already included in an IRWE or BWE (~).  Enter numbers only.  Do not enter $") unless @PassAmt.blank?

          # calc to insert
           @RPassAmtAllowableAnswer  = WebCalc.find_by_name('RPassAmtAllowableAnswer')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @PassAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @PassAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RPassAmtAllowableAnswer.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @PassAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RPassAmtAllowableAnswer.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
