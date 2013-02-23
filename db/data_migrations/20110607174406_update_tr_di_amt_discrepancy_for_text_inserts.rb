class UpdateTrDiAmtDiscrepancyForTextInserts < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

       #Alert - SSDI (Title II) Check Amount Error:  You entered ~SsdiActualAmt~  as your monthly SSDI (Title II) benefit amount that you receive.  WorkWORLD calculations indicate you should be receiving  ~R_SsdiPayAllAdjustAmt.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.
       #TRDiAmtDiscrepancy
                      
      @TRDiAmtDiscrepancy = WebTextResult.find_by_name('TRDiAmtDiscrepancy')
      @TRDiAmtDiscrepancy.update_attribute(:text, "Alert - SSDI (Title II) Check Amount Error:  You entered ~ as your monthly SSDI (Title II) benefit amount that you receive.  WorkWORLD calculations indicate you should be receiving  ~.  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.") 
      #could make this more robust for now we will assume a succesful find

    # now add items to insert
    #SsdiActualAmt
      @Q_SsdiActualAmt  = WebCalc.find_by_name('Q_SsdiActualAmt')
      #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
     if @Q_SsdiActualAmt.blank? then
        @Q_SsdiActualAmt  = WebCalc.new(:name => 'Q_SsdiActualAmt', :operation => "SitDate = manager.get_answer_by_question_name('SsdiActualAmt')")
        @Q_SsdiActualAmt.save!
    end

     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRDiAmtDiscrepancy.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRDiAmtDiscrepancy.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SsdiActualAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRDiAmtDiscrepancy.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SsdiActualAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end

     #2nd insert R_SsdiPayAllAdjustAmt
     @R_SsdiPayAllAdjustAmt  = WebCalc.find_by_name('R_SsdiPayAllAdjustAmt')

     @Insert2 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRDiAmtDiscrepancy.id, 2])
     if @Insert2.blank? then
        @Insert2  = TextResultInsert.new(:web_text_result_id => @TRDiAmtDiscrepancy.id, :insert_number => '2', :webcalc_id_to_insert => @R_SsdiPayAllAdjustAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_text_result_id, @TRDiAmtDiscrepancy.id)
      @Insert2.update_attribute(:insert_number, '2')
      @Insert2.update_attribute(:webcalc_id_to_insert, @R_SsdiPayAllAdjustAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
     
  end

  def self.down
  end
end
