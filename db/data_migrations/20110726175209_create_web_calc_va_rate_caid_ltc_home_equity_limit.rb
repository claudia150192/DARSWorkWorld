class CreateWebCalcVaRateCaidLtcHomeEquityLimit < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  

      #used in question 82.03	Do you have a home and property that has an equity value of over ~VA_RateCaidLtcHomeEquityLimit~ ?
      
       @VA_RateCaidLtcHomeEquityLimit = WebCalc.find_by_name('VA_RateCaidLtcHomeEquityLimit')
       if @VA_RateCaidLtcHomeEquityLimit.blank? then
          @VA_RateCaidLtcHomeEquityLimit  = WebCalc.new(:name => 'VA_RateCaidLtcHomeEquityLimit')
       end

     @VA_RateCaidLtcHomeEquityLimit.operation = "
    unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = VaMedicaidRate.find(:last, :conditions => ['start_date <= ?', SitDate])
        if !(rate.blank?) then
          VA_RateCaidLtcHomeEquityLimit = rate.va_rate_caid_ltc_home_equity_limit
        else
            506000
        end
       else
         506000
       end"

    @VA_RateCaidLtcHomeEquityLimit.save!
  end

  def self.down
  end
end
