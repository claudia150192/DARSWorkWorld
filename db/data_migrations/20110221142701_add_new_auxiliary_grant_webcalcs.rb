class AddNewAuxiliaryGrantWebcalcs < ActiveRecord::Migration
  def self.up
    
    @RateVaMaxAuxiliaryGrantPd8  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantPd8')
    if @RateVaMaxAuxiliaryGrantPd8.blank? then
      @RateVaMaxAuxiliaryGrantPd8  = WebCalc.new(:name => 'RateVaMaxAuxiliaryGrantPd8')
    end
      
    @RateVaMaxAuxiliaryGrantPd8.update_attribute(:operation, 
    "unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
       rate = VaMaxAuxiliaryGrantFacilityRate.find(:first, :conditions => ['start_date <= ?', SitDate])
       if !(rate.blank?) then
         RateVaMaxAuxiliaryGrantPd8 = rate.pd_8_amount
       else
         answer = 605
       end
    else 
      605
    end
    ")
    

  @RateVaMaxAuxiliaryGrantCouplePd8  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCouplePd8')
  if @RateVaMaxAuxiliaryGrantCouplePd8.blank? then
    @RateVaMaxAuxiliaryGrantCouplePd8  = WebCalc.new(:name => 'RateVaMaxAuxiliaryGrantCouplePd8')
  end
    
  @RateVaMaxAuxiliaryGrantCouplePd8.update_attribute(:operation, 
  "unless manager.get_answer_by_question_name('SitDate').blank? 
   SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
   rate = VaMaxAuxiliaryGrantFacilityRate.find(:first, :conditions => ['start_date <= ?', SitDate])
   if !(rate.blank?) then
    RateVaMaxAuxiliaryGrantCouplePd8 = rate.couple_pd_8_amount
   else
     answer = 1279
   end
  else 
   1279
  end
  ")
 
 
 @RateVaMaxAuxiliaryGrantElsewhere  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantElsewhere')
 if @RateVaMaxAuxiliaryGrantElsewhere.blank? then
   @RateVaMaxAuxiliaryGrantElsewhere  = WebCalc.new(:name => 'RateVaMaxAuxiliaryGrantElsewhere')
 end
   
 @RateVaMaxAuxiliaryGrantElsewhere.update_attribute(:operation,
 "unless manager.get_answer_by_question_name('SitDate').blank? 
    SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
    rate = VaMaxAuxiliaryGrantFacilityRate.find(:first, :conditions => ['start_date <= ?', SitDate])
    if !(rate.blank?) then
      RateVaMaxAuxiliaryGrantElsewhere = rate.elsewhere_amount
    else
      answer = 438
    end
  else 
   438
  end")
 
 @RateVaMaxAuxiliaryGrantCoupleElsewhere  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCoupleElsewhere')
  if @RateVaMaxAuxiliaryGrantCoupleElsewhere.blank? then
    @RateVaMaxAuxiliaryGrantCoupleElsewhere  = WebCalc.new(:name => 'RateVaMaxAuxiliaryGrantCoupleElsewhere')
  end

  @RateVaMaxAuxiliaryGrantCoupleElsewhere.update_attribute(:operation,
  "unless manager.get_answer_by_question_name('SitDate').blank? 
   SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
   rate = VaMaxAuxiliaryGrantFacilityRate.find(:first, :conditions => ['start_date <= ?', SitDate])
   if !(rate.blank?) then
    RateVaMaxAuxiliaryGrantCoupleElsewhere = rate.couple_elsewhere_amount
   else
     answer = 1112
   end
  else 
   1112
  end
  ")
  
 end
 
  def self.down

    @RateVaMaxAuxiliaryGrantCoupleElsewhere  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCoupleElsewhere')
    @RateVaMaxAuxiliaryGrantCoupleElsewhere.delete
    
    @RateVaMaxAuxiliaryGrantElsewhere  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantElsewhere')
    @RateVaMaxAuxiliaryGrantElsewhere.delete
    
    @RateVaMaxAuxiliaryGrantCouplePd8  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCouplePd8')
    @RateVaMaxAuxiliaryGrantCouplePd8.delete

    @RateVaMaxAuxiliaryGrantPd8  = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantPd8')
    @RateVaMaxAuxiliaryGrantPd8.delete
  end



end
