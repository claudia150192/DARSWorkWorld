class UpdateTrAgeLessThan15YrsFor < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

       #Alert - On the Situation Date (~SitDate~) your age is ~RAge~.  This version of WW-Web may not provide correct results for those under 15 years old. If you choose a future Situation Date when you are at least 15 years old, WW-Web will calculate results based on current benefit levels.
 
      @TRAgeLessThan15Yrs = WebTextResult.find_by_name('TRAgeLessThan15Yrs')
      @TRAgeLessThan15Yrs.update_attribute(:text, "Alert - On the Situation Date ~ your age is ~.  This version of WW-Web may not provide correct results for those under 15 years old. If you choose a future Situation Date when you are at least 15 years old, WW-Web will calculate results based on current benefit levels.") 
      #could make this more robust for now we will assume a succesful find

    # now add items to insert
    
      @Q_SitDate  = WebCalc.find_by_name('Q_SitDate')
      if @Q_SitDate.blank? then
         @Q_SitDate  = WebCalc.new(:name => 'Q_SitDate', :operation => "SitDate = manager.get_answer_by_question_name('SitDate')")
         @Q_SitDate.save!
     end


     @Insert1 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRAgeLessThan15Yrs.id, 1])
     if @Insert1.blank? then
        @Insert1  = TextResultInsert.new(:web_text_result_id => @TRAgeLessThan15Yrs.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SitDate.id, :insert_marker => "~", :insert_type => 'string_detail')
        @Insert1.save!
    else
      @Insert1.update_attribute(:web_text_result_id, @TRAgeLessThan15Yrs.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SitDate.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'string_detail')
     end


     #2nd insert
     @RAge  = WebCalc.find_by_name('RAge')

     @Insert2 = TextResultInsert.find(:first, :conditions => ['web_text_result_id = ? AND insert_number = ?',  @TRAgeLessThan15Yrs.id, 2])
     if @Insert2.blank? then
        @Insert2  = TextResultInsert.new(:web_text_result_id => @TRAgeLessThan15Yrs.id, :insert_number => '2', :webcalc_id_to_insert => @RAge.id, :insert_marker => "~", :insert_type => 'string_detail')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_text_result_id, @TRAgeLessThan15Yrs.id)
      @Insert2.update_attribute(:insert_number, '2')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RAge.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'string_detail')
     end
    
  end

  def self.down
  end
end
