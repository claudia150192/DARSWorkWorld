class UpdateWebtipDisabledNotBlindDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_DisabledNotBlind = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_DisabledNotBlind'])
    
    #IF Blind = NO AND Disability = YES
            
    @Tip_DisabledNotBlind.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      Blind = manager.get_answer_by_question_name('Blind')
      Disability = manager.get_answer_by_question_name('Disability')
      if (Blind == 'No' && Disability == 'Yes') then
         true
       else
         false
       end
    else
      false
    end") unless @Tip_DisabledNotBlind.blank?
  end

  def self.down
  end
end
