class UpdateTrSsiAmtDiscrepancyFor < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

       #Alert - SSI Check Amount Error:   You entered  ~SsiUserActualAmt~ as your monthly SSI benefit amount.  WorkWORLD calculations indicate you should be receiving  ~R_SsiUserOverUnderAdjustCalcAmt~.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.
        
      @TRSsiAmtDiscrepancy = WebTextResult.find_by_name('TRSsiAmtDiscrepancy')
      @TRSsiAmtDiscrepancy.update_attribute(:text, "Alert - SSI Check Amount Error: You entered ~ as your monthly SSI benefit amount.  WorkWORLD calculations indicate you should be receiving ~.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.") 
      #could make this more robust for now we will assume a succesful find

    # now add items to insert
    #SsiUserActualAmt
      @Q_SsiUserActualAmt  = WebCalc.find_by_name('Q_SsiUserActualAmt')
      #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
     if @Q_SsiUserActualAmt.blank? then
        @Q_SsiUserActualAmt  = WebCalc.new(:name => 'Q_SsiUserActualAmt', :operation => "SitDate = manager.get_answer_by_question_name('SsiUserActualAmt')")
        @Q_SsiUserActualAmt.save!
    end

     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRSsiAmtDiscrepancy.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRSsiAmtDiscrepancy.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SsiUserActualAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRSsiAmtDiscrepancy.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SsiUserActualAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end


     #2nd insert R_SsiUserOverUnderAdjustCalcAmt
     @R_SsiUserOverUnderAdjustCalcAmt  = WebCalc.find_by_name('R_SsiUserOverUnderAdjustCalcAmt')

     @Insert2 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRSsiAmtDiscrepancy.id, 2])
     if @Insert2.blank? then
        @Insert2  = TextResultInsert.new(:web_text_result_id => @TRSsiAmtDiscrepancy.id, :insert_number => '2', :webcalc_id_to_insert => @R_SsiUserOverUnderAdjustCalcAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_text_result_id, @TRSsiAmtDiscrepancy.id)
      @Insert2.update_attribute(:insert_number, '2')
      @Insert2.update_attribute(:webcalc_id_to_insert, @R_SsiUserOverUnderAdjustCalcAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
    
  end

  def self.down
  end
end
