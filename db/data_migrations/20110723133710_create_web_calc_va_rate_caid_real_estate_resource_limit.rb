class CreateWebCalcVaRateCaidRealEstateResourceLimit < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  

       @VA_RateCaidRealEstateResourceLimit = WebCalc.find_by_name('VA_RateCaidRealEstateResourceLimit')
       if @VA_RateCaidRealEstateResourceLimit.blank? then
          @VA_RateCaidRealEstateResourceLimit  = WebCalc.new(:name => 'VA_RateCaidRealEstateResourceLimit')
       end

     @VA_RateCaidRealEstateResourceLimit.operation = "
    unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = VaMedicaidRate.find(:last, :conditions => ['start_date <= ?', SitDate])
        if !(rate.blank?) then
          VA_RateCaidRealEstateResourceLimit = rate.va_rate_caid_real_estate_resource_limit
        else
            5000
        end
       else
         5000
       end"

    @VA_RateCaidRealEstateResourceLimit.save!
    
  end

  def self.down
  end
end
