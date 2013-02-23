class UpdateWebtipTipBlindDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_Blind = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Blind'])
    
    #IF Blind = YES
    @Tip_Blind.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      Blind = manager.get_answer_by_question_name('Blind')
      if (Blind == 'Yes') then
         true
       else
         false
       end
    else
      false
    end") unless @Tip_Blind.blank?
  end

  def self.down
  end
end
