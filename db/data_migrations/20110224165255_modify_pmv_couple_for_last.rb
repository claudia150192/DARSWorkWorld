class ModifyPmvCoupleForLast < ActiveRecord::Migration
    def self.up
      @RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt')
      if @RatePmvCoupleAmt.blank? then
        @RatePmvCoupleAmt = WebCalc.new(:name => 'RatePmvCoupleAmt')
      end

  @RatePmvCoupleAmt.update_attribute(:operation, 
  "unless manager.get_answer_by_question_name('SitDate').blank? 
   SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
   rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
   if !(rate.blank?) then
     RatePmvCoupleAmt = rate.pmv_couple_amount
    else
      RatePmvCoupleAmt = 357
    end
    return RatePmvCoupleAmt
   else 
    357
  end
  ")
    end

    def self.down
      @RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt')
      if !(@RatePmvCoupleAmt.blank?) then
       @RatePmvCoupleAmt.update_attribute(:operation,
       "unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
        if !(rate.blank?) then
          RatePmvCoupleAmt = rate.pmv_couple_amount
         else
           RatePmvCoupleAmt = 357
         end
         return RatePmvCoupleAmt
        else 
         357
       end
       ")
    end
    end
  end