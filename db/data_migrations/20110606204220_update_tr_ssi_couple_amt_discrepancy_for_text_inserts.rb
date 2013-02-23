class UpdateTrSsiCoupleAmtDiscrepancyForTextInserts < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

       #Alert - SSI Check Amount Error:   You entered ~SsiSpouseActualAmt  as the total monthly SSI benefit amount that you and your spouse receive.  WorkWORLD calculations indicate you should be receiving  ~R_SsiCoupleOverUnderAdjustCalcAmt.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.
               
      @TRSsiCoupleAmtDiscrepancy = WebTextResult.find_by_name('TRSsiCoupleAmtDiscrepancy')
      @TRSsiCoupleAmtDiscrepancy.update_attribute(:text, "Alert - SSI Check Amount Error:  You entered ~ as the total monthly SSI benefit amount that you and your spouse receive.  WorkWORLD calculations indicate you should be receiving  ~.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.") 
      #could make this more robust for now we will assume a succesful find

    # now add items to insert
    #SsiSpouseActualAmt
      @Q_SsiSpouseActualAmt  = WebCalc.find_by_name('Q_SsiSpouseActualAmt')
      #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
     if @Q_SsiSpouseActualAmt.blank? then
        @Q_SsiSpouseActualAmt  = WebCalc.new(:name => 'Q_SsiSpouseActualAmt', :operation => "SitDate = manager.get_answer_by_question_name('SsiSpouseActualAmt')")
        @Q_SsiSpouseActualAmt.save!
    end

     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRSsiCoupleAmtDiscrepancy.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRSsiCoupleAmtDiscrepancy.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SsiSpouseActualAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRSsiCoupleAmtDiscrepancy.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SsiSpouseActualAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end


     #2nd insert R_SsiCoupleOverUnderAdjustCalcAmt
     @R_SsiCoupleOverUnderAdjustCalcAmt  = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')

     @Insert2 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRSsiCoupleAmtDiscrepancy.id, 2])
     if @Insert2.blank? then
        @Insert2  = TextResultInsert.new(:web_text_result_id => @TRSsiCoupleAmtDiscrepancy.id, :insert_number => '2', :webcalc_id_to_insert => @R_SsiCoupleOverUnderAdjustCalcAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_text_result_id, @TRSsiCoupleAmtDiscrepancy.id)
      @Insert2.update_attribute(:insert_number, '2')
      @Insert2.update_attribute(:webcalc_id_to_insert, @R_SsiCoupleOverUnderAdjustCalcAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
