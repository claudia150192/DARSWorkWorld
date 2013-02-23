class CreateWebcalcsForSsiResourceLimits < ActiveRecord::Migration
  def self.up

     require 'wwweb_session_manager'  
    
    #RateSsiResourceLimit 

   @RateSsiResourceLimit = WebCalc.find_by_name('RateSsiResourceLimit')
   if @RateSsiResourceLimit.blank? then
     @RateSsiResourceLimit  = WebCalc.new(:name => 'RateSsiResourceLimit')
   end
        
    @RateSsiResourceLimit.operation = "
    unless manager.get_answer_by_question_name('SitDate').blank? 
   SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
           rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
          RateSsiResourceLimit = rate.RateSsiResourceLimit
      else
         RateSsiResourceLimit =  2000.00
      end
     "
     @RateSsiResourceLimit.save!


  @RateCoupleSsiResourceLimit = WebCalc.find_by_name('RateCoupleSsiResourceLimit')
   if @RateCoupleSsiResourceLimit.blank? then
      @RateCoupleSsiResourceLimit  = WebCalc.new(:name => 'RateCoupleSsiResourceLimit')
   end

    @RateCoupleSsiResourceLimit.operation = "
    unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
           rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
          RateCoupleSsiResourceLimit = rate.RateCoupleSsiResourceLimit
      else
         RateCoupleSsiResourceLimit =  3000.00
      end
     "
     @RateCoupleSsiResourceLimit.save!


 end

  def self.down
  end
end