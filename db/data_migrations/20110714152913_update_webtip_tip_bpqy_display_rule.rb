class UpdateWebtipTipBpqyDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_BPQY = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_BPQY'])
    
    #IF BPQY = NO
    @Tip_BPQY.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      BPQY = manager.get_answer_by_question_name('BPQY')
      if (BPQY == 'No') then
         true
       else
         false
       end
    else
      false
    end") unless @Tip_BPQY.blank?
  end

  def self.down
  end
end
