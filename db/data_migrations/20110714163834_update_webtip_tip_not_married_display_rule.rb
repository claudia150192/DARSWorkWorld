class UpdateWebtipTipNotMarriedDisplayRule < ActiveRecord::Migration
  def self.up
     @Tip_NotMarried = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_NotMarried'])

      #IF LiveWithSpouse = NO
      @Tip_NotMarried.update_attribute(:display_rules, "
      unless manager.get_answer_by_question_name('SitDate').blank? 
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        if (LiveWithSpouse == 'No') then
           true
         else
           false
         end
      else
        false
      end") unless @Tip_NotMarried.blank?
  end

  def self.down
  end
end
