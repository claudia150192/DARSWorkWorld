class CreateMoreWebCalcResourceRates < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager' 
    
    #Do you have countable resources that exceed the <RateQwdiResouceLimit> QDWI Medicaid resource limit? (Include any deemed resources.)
                                                    # RateQwdiResouceLimit
    
    @RateQwdiResouceLimit = WebCalc.find_by_name('RateQwdiResouceLimit')
    if @RateQwdiResouceLimit.blank? then
      @RateQwdiResouceLimit  = WebCalc.new(:name => 'RateQwdiResouceLimit')
    end

     @RateQwdiResouceLimit.operation = "
     unless manager.get_answer_by_question_name('SitDate').blank? 
    SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
            rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
           RateQwdiResouceLimit = rate.RateQwdiResouceLimit
       else
          RateQwdiResouceLimit =  4000
       end
      "
      @RateQwdiResouceLimit.save!
      
    
    #  Do you and your spouse have countable resources that exceed the <RateCoupleQwdiResouceLimit>  QWDI Medicaid resource limit? (Include any deemed resources.)
                                                        
     @RateCoupleQwdiResouceLimit = WebCalc.find_by_name('RateCoupleQwdiResouceLimit')
     if @RateCoupleQwdiResouceLimit.blank? then
       @RateCoupleQwdiResouceLimit  = WebCalc.new(:name => 'RateCoupleQwdiResouceLimit')
     end

      @RateCoupleQwdiResouceLimit.operation = "
      unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
             rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
            RateCoupleQwdiResouceLimit = rate.RateCoupleQwdiResouceLimit
        else
           RateCoupleQwdiResouceLimit =  6000
        end
       "
       @RateCoupleQwdiResouceLimit.save! 
   
   
   #    Do you have countable resources that exceed the <RateQmbSlmbQiResouceLimit> resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)
      @RateQmbSlmbQiResouceLimit = WebCalc.find_by_name('RateQmbSlmbQiResouceLimit')
       if @RateQmbSlmbQiResouceLimit.blank? then
         @RateQmbSlmbQiResouceLimit  = WebCalc.new(:name => 'RateQmbSlmbQiResouceLimit')
       end

        @RateQmbSlmbQiResouceLimit.operation = "
        unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
               rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
              RateQmbSlmbQiResouceLimit = rate.RateQmbSlmbQiResouceLimit
          else
             RateQmbSlmbQiResouceLimit =  6680
          end
         "
         @RateQmbSlmbQiResouceLimit.save!
         
         
  #       Do you and your spouse have countable resources that exceed the <RateCoupleQmbSlmbQiResouceLimit> resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)
       @RateCoupleQmbSlmbQiResouceLimit = WebCalc.find_by_name('RateCoupleQmbSlmbQiResouceLimit')
        if @RateCoupleQmbSlmbQiResouceLimit.blank? then
          @RateCoupleQmbSlmbQiResouceLimit  = WebCalc.new(:name => 'RateCoupleQmbSlmbQiResouceLimit')
        end

         @RateCoupleQmbSlmbQiResouceLimit.operation = "
         unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
                rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
               RateCoupleQmbSlmbQiResouceLimit = rate.RateCoupleQmbSlmbQiResouceLimit
           else
              RateCoupleQmbSlmbQiResouceLimit =  10020
           end
          "
          @RateCoupleQmbSlmbQiResouceLimit.save!  
         
         
    #      Do you have countable resources that exceed the <VA_RateCaidWorksResourceLimit> resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)
    @VA_RateCaidWorksResourceLimit = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')
      if @VA_RateCaidWorksResourceLimit.blank? then
        @VA_RateCaidWorksResourceLimit  = WebCalc.new(:name => 'VA_RateCaidWorksResourceLimit')
      end

       @VA_RateCaidWorksResourceLimit.operation = "
       unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
              rate = VaMedicaidRate.find(:last, :conditions => ['start_date <= ?', SitDate])
             VA_RateCaidWorksResourceLimit = rate.va_rate_caid_works_resource_limit
         else                                     
            VA_RateCaidWorksResourceLimit =  32545
         end
        "
        @VA_RateCaidWorksResourceLimit.save!  
    
  end

  def self.down
  end
end
