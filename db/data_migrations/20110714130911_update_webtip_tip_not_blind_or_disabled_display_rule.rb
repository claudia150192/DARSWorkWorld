class UpdateWebtipTipNotBlindOrDisabledDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_NotBlindOrDisabled = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_NotBlindOrDisabled'])
    
    #IF Blind = NO AND Disability = NO
        
    @Tip_NotBlindOrDisabled.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      Blind = manager.get_answer_by_question_name('Blind')
      Disability = manager.get_answer_by_question_name('Disability')
      if (Blind == 'No' && Disability == 'No') then
         true
       else
         false
       end
    else
      false
    end") unless @Tip_NotBlindOrDisabled.blank?
  end

  def self.down
  end
end
