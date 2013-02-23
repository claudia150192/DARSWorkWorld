class CreateWebCalcRateCareBPremium < ActiveRecord::Migration
  def self.up
  
       require 'wwweb_session_manager'  

      @RateCareBPremium  = WebCalc.new(:name => 'RateCareBPremium')
      @RateCareBPremium.operation = "
     unless manager.get_answer_by_question_name('SitDate').blank? 
         SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
         rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
         if !(rate.blank?) then
           RateCareBPremium = rate.RateCareBPremium
         else
             96.5
         end
        else
          96.5
        end"
     @RateCareBPremium.save!
  end

  def self.down
  end
end
