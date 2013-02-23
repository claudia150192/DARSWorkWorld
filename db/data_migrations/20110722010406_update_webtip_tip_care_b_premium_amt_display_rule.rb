class UpdateWebtipTipCareBPremiumAmtDisplayRule < ActiveRecord::Migration
  def self.up
    @Tip_CareBPremiumAmt = WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_CareBPremiumAmt'])   
  
  #CaidGet added by RMC even though not in workbook
   # IF CareBDeduct = NO AND CareBPaySelf = NO AND CareBPremiumAmt = RateCareBPremium
    @Tip_CareBPremiumAmt.update_attribute(:display_rules, "
    State = manager.get_answer_by_question_name('State')
    CaidGet = manager.get_answer_by_question_name('CaidGet')
    CareBDeduct = manager.get_answer_by_question_name('CareBDeduct')
    CareBPaySelf = manager.get_answer_by_question_name('CareBPaySelf')
    RateCareBPremium = WebCalc.find_by_name('RateCareBPremium')
    RateCareBPremium = Float(RateCareBPremium.calculate manager)
    CareBPremiumAmt = manager.get_answer_by_question_name('CareBPremiumAmt')
    State == 'Virginia' && CaidGet == 'Yes' && CareBDeduct == 'No' && CareBPaySelf == 'No' && RateCareBPremium == CareBPremiumAmt.to_f") unless @Tip_CareBPremiumAmt.blank?

  end

  def self.down
  end
end
