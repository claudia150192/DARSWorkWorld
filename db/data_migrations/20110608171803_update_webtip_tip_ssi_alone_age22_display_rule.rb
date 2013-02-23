class UpdateWebtipTipSsiAloneAge22DisplayRule < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  
      
    @Tip_SsiAloneAge22 = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_SsiAloneAge22']) 
   
   # IF SsiGet = YES AND Alone = YES AND RAge >= 22
   
    @Tip_SsiAloneAge22.update_attribute(:display_rules, "
    RAge = WebCalc.find_by_name('RAge')
    Age = RAge.calculate manager
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    Alone = manager.get_answer_by_question_name('Alone')
    if SsiGet == 'Yes' && Alone == 'Yes' && Age >= 22 then 
      true
    else
      false
    end    
    ") 
   
  end

  def self.down
  end
end
