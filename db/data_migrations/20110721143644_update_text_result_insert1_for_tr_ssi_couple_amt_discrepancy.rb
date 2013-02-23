class UpdateTextResultInsert1ForTrSsiCoupleAmtDiscrepancy < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

       #Alert - SSI Check Amount Error:   You entered ~SsiSpouseActualAmt  as the total monthly SSI benefit amount that you and your spouse receive.  WorkWORLD calculations indicate you should be receiving  ~R_SsiCoupleOverUnderAdjustCalcAmt.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.
               
      @TRSsiCoupleAmtDiscrepancy = WebTextResult.find_by_name('TRSsiCoupleAmtDiscrepancy')
      
    # now add items to insert
    #R_SsiActualAmt
      @R_SsiActualAmt  = WebCalc.find_by_name('R_SsiActualAmt')
      #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
    

     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRSsiCoupleAmtDiscrepancy.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRSsiCoupleAmtDiscrepancy.id, :insert_number => '1', :webcalc_id_to_insert => @R_SsiActualAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRSsiCoupleAmtDiscrepancy.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @R_SsiActualAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end


     #2nd insert seems fine
     
  end

  def self.down
  end
end
