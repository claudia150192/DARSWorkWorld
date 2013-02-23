class UpdateWebtipTipLiveWithOthersDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_LiveWithOthers = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_LiveWithOthers'])

      #IF LiveWithSpouse = YES OR Alone = NO
      
      @Tip_LiveWithOthers.update_attribute(:display_rules, "
      unless manager.get_answer_by_question_name('SitDate').blank? 
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        Alone = manager.get_answer_by_question_name('Alone')
        if (LiveWithSpouse == 'Yes' || Alone == 'No') then
           true
         else
           false
         end
      else
        false
      end") unless @Tip_LiveWithOthers.blank?
  end

  def self.down
  end
end
