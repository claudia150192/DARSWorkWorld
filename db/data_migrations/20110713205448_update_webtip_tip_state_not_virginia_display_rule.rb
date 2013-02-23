class UpdateWebtipTipStateNotVirginiaDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_StateNotVirginia = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_StateNotVirginia'])
    
   
    @Tip_StateNotVirginia.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('State').blank? 
     state1= manager.get_answer_by_question_name('State')
      if state1 != 'Virginia' then
         return true
       else
         return false
       end
    else
      false
    end") unless @Tip_StateNotVirginia.blank?
  end

  def self.down
  end
end
