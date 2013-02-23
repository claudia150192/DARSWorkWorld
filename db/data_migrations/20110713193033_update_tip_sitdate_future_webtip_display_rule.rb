class UpdateTipSitdateFutureWebtipDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_SitdateFuture = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_SitdateFuture'])
    
    #If SitDate = A month later than the month of TodaysDate
    
    @Tip_SitdateFuture.update_attribute(:display_rules, "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      if (SitDate > Date.today && SitDate.month > Date.today.month) then
         return true
       else
         return false
       end
    else
      false
    end") unless @Tip_SitdateFuture.blank?
  end

  def self.down
  end
end
