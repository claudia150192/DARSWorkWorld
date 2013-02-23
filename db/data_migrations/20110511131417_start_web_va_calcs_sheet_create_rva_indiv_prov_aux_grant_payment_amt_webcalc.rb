class StartWebVaCalcsSheetCreateRvaIndivProvAuxGrantPaymentAmtWebcalc < ActiveRecord::Migration
  def self.up
  
    require 'wwweb_session_manager'  

   #  140	R_VA_IndivProvAuxGrantPaymentAmt = IF VA_LiveInAuxGrantFacility = Y AND SsiResourceLimitExceed <> Y, THEN VA_AuxGrantFacilityRateAmt - RateFbrAmt + VA_RateAGPersonalAllowance, ELSE 0.00	R_VA_IndivProvAuxGrantPaymentAmt
   #NOTE this will need to be revised when VA_RateAGPersonalAllowance table/field is set up  hard wired to $70 now
   @R_VA_IndivProvAuxGrantPaymentAmt  = WebCalc.new(:name => 'R_VA_IndivProvAuxGrantPaymentAmt')
   @R_VA_IndivProvAuxGrantPaymentAmt.operation = "
     VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
     SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed')
     VA_AuxGrantFacilityRateAmt = manager.get_answer_by_question_name('VA_AuxGrantFacilityRateAmt')
     unless manager.get_answer_by_question_name('SitDate').blank? 
         SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
         FbrRecord = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
         RateFbrAmt = FbrRecord.fbr_amount
         VA_RateAGPersonalAllowance = 70.00
     else
        RateFbrAmt =  674.01
     end

     if VA_LiveInAuxGrantFacility == 'Yes' &&  SsiResourceLimitExceed != 'Yes' then
      returnval = VA_AuxGrantFacilityRateAmt.to_f - RateFbrAmt + VA_RateAGPersonalAllowance
     else
       0  
     end
    "
    @R_VA_IndivProvAuxGrantPaymentAmt.save!  
    
  end

  def self.down
  end
end
