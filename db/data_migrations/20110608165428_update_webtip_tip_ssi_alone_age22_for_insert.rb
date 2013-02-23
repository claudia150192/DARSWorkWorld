class UpdateWebtipTipSsiAloneAge22ForInsert < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  
       #first webTip Insert
       #Since you live alone the maximum amount of your SSI benefit is ~RateFbrAmt~.  Your SSI cash benefit will be less if you have other income.  You may, however, be able to use work incentives to decrease or even eliminate the decrease in benefits.  After you enter information about your income and expenses, WW-Web will tell you which work incentives may work best in your situation.
       #Tip_SsiAloneAge22
       
       @Tip_SsiAloneAge22 = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_SsiAloneAge22']) 
      #@Tip_SsiAloneAge22 = WebTip.find_by_name('Tip_SsiAloneAge22')
      @Tip_SsiAloneAge22.update_attribute(:text, "Since you live alone the maximum amount of your SSI benefit is ~.  Your SSI cash benefit will be less if you have other income.  You may, however, be able to use work incentives to decrease or even eliminate the decrease in benefits.  After you enter information about your income and expenses, WW-Web will tell you which work incentives may work best in your situation.") 
      #could make this more robust for now we will assume a succesful find

     # insert
     @RateFbrAmt  = WebCalc.find_by_name('RateFbrAmt')

     @Insert2 = WebTipInsert.find(:first, :conditions => ['web_tip_id = ? AND insert_number = ?',  @Tip_SsiAloneAge22.id, 1])
     if @Insert2.blank? then
        @Insert2  = WebTipInsert.new(:web_tip_id => @Tip_SsiAloneAge22.id, :insert_number => '1', :webcalc_id_to_insert => @RateFbrAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:web_tip_id, @Tip_SsiAloneAge22.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RateFbrAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
    
  end

  def self.down
  end
end
