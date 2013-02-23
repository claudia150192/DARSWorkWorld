class CreateRvaCoupleProvAuxGrantPaymentAmtWebcalc < ActiveRecord::Migration
  def self.up
  
   require 'wwweb_session_manager'  
 
  # 150	R_VA_CoupleProvAuxGrantPaymentAmt = IF VA_LiveWithSpouseAuxGrantFacility = Y AND SsiCoupleResourceLimitExceed <> Y, THEN VA_CoupleAuxGrantFacilityRateAmt - RateFbrCoupleAmt + (VA_RateAGPersonalAllowance times 2), ELSE 0.00	R_VA_CoupleProvAuxGrantPaymentAmt
  
  #NOTE this will need to be revised when VA_RateAGPersonalAllowance table/field is set up  hard wired to $70 now
  @R_VA_CoupleProvAuxGrantPaymentAmt  = WebCalc.new(:name => 'R_VA_CoupleProvAuxGrantPaymentAmt')
  @R_VA_CoupleProvAuxGrantPaymentAmt.operation = "
    VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
    SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
    VA_CoupleAuxGrantFacilityRateAmt = manager.get_answer_by_question_name('VA_CoupleAuxGrantFacilityRateAmt')
    unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        FbrRecord = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
        RateFbrCoupleAmt = FbrRecord.fbr_couple_amount
        VA_RateAGPersonalAllowance = 70.00
    else
       RateFbrCoupleAmt =  1011.00
    end
 
    if VA_LiveWithSpouseAuxGrantFacility == 'Yes' &&  SsiCoupleResourceLimitExceed != 'Yes' then
     returnval = VA_CoupleAuxGrantFacilityRateAmt.to_f - RateFbrCoupleAmt + (VA_RateAGPersonalAllowance * 2)
    else
      0  
    end
   "
   @R_VA_CoupleProvAuxGrantPaymentAmt.save!
  
  
  end

  def self.down
  end
end
