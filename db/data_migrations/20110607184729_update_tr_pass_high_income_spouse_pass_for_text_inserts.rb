class UpdateTrPassHighIncomeSpousePassForTextInserts < ActiveRecord::Migration
  def self.up
     
     require 'wwweb_session_manager'  

       #Alert - PASSes (Yours and Spouse's) Higher than Available Income:  Your PASS (~PassAmt~) can not be greater than  ~, the amount of income (excluding SSI cash benefits--but including deemed income and in-kind support under the PMV rule) that you have available to set aside for employability investments and work expenses. Income your spouse is setting aside in a PASS (~SpousePassAmt~) is not available. YOU OR YOUR SPOUSE'S PASS MUST BE REDUCED OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!
       # #170 TRPassHighIncomeSpousePASS
      #       TRSpousePASSHighIncomeUserPASS 
      #       TRPassHighIncomeSpousePASS      
      
      @TRPassHighIncomeSpousePASS = WebTextResult.find_by_name('TRPassHighIncomeSpousePASS')
      @TRPassHighIncomeSpousePASS.update_attribute(:text, "Alert - PASSes (Yours and Spouse's) Higher than Available Income:  Your PASS (~) can not be greater than  ~, the amount of income (excluding SSI cash benefits--but including deemed income and in-kind support under the PMV rule) that you have available to set aside for employability investments and work expenses. Income your spouse is setting aside in a PASS (~) is not available. YOU OR YOUR SPOUSE'S PASS MUST BE REDUCED OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!")
      #could make this more robust for now we will assume a succesful find

    # now add items to insert
    #PassAmt
      @Q_PassAmt  = WebCalc.find_by_name('Q_PassAmt')
      #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
     if @Q_PassAmt.blank? then
        @Q_PassAmt  = WebCalc.new(:name => 'Q_PassAmt', :operation => "SitDate = manager.get_answer_by_question_name('PassAmt')")
        @Q_PassAmt.save!
    end

     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRPassHighIncomeSpousePASS.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRPassHighIncomeSpousePASS.id, :insert_number => '1', :webcalc_id_to_insert => @Q_PassAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRPassHighIncomeSpousePASS.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_PassAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end

     #2nd insert RIncAvailForPassMinusSpousePassAmt               RIncAvailForPassMinusSpousePassAmt
     @RIncAvailForPassMinusSpousePassAmt  = WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt')

     @Insert2 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRPassHighIncomeSpousePASS.id, 2])
     if @Insert2.blank? then
        @Insert2  = TextResultInsert.new(:web_text_result_id => @TRPassHighIncomeSpousePASS.id, :insert_number => '2', :webcalc_id_to_insert => @RIncAvailForPassMinusSpousePassAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_text_result_id, @TRPassHighIncomeSpousePASS.id)
      @Insert2.update_attribute(:insert_number, '2')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RIncAvailForPassMinusSpousePassAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  
     # Special insert #3
     #SpousePassAmt
         @Q_SpousePassAmt  = WebCalc.find_by_name('Q_SpousePassAmt')
       #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
      if @Q_SpousePassAmt.blank? then
         @Q_SpousePassAmt  = WebCalc.new(:name => 'Q_SpousePassAmt', :operation => "SitDate = manager.get_answer_by_question_name('SpousePassAmt')")
         @Q_SpousePassAmt.save!
     end

      @Insert3 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRPassHighIncomeSpousePASS.id, 3])
      if @Insert3.blank? then
         @Insert3  = TextResultInsert.new(:web_text_result_id => @TRPassHighIncomeSpousePASS.id, :insert_number => '3', :webcalc_id_to_insert => @Q_SpousePassAmt.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert3.save!
     else
       @Insert3.update_attribute(:web_text_result_id, @TRPassHighIncomeSpousePASS.id)
       @Insert3.update_attribute(:insert_number, '3')
       @Insert3.update_attribute(:webcalc_id_to_insert, @Q_SpousePassAmt.id)
       @Insert3.update_attribute(:insert_marker, '~')
       @Insert3.update_attribute(:insert_type, 'currency')
      end
   
  end

  def self.down
  end
end
