class CreateRvaProvAuxGrantPaymentAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

      #160	R_VA_ProvAuxGrantPaymentAmt = IF VA_LiveInAuxGrantFacility = Y, THEN R_VA_IndivProvAuxGrantPaymentAmt, ELSE IF  VA_LiveWithSpouseAuxGrantFacility = Y, THEN R_VA_CoupleProvAuxGrantPaymentAmt, ELSE 0.00	R_VA_ProvAuxGrantPaymentAmt
            
    @R_VA_ProvAuxGrantPaymentAmt  = WebCalc.new(:name => 'R_VA_ProvAuxGrantPaymentAmt')
    @R_VA_ProvAuxGrantPaymentAmt.operation = "
   VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
   VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
   R_VA_IndivProvAuxGrantPaymentAmt = WebCalc.find_by_name('R_VA_IndivProvAuxGrantPaymentAmt')
   R_VA_IndivProvAuxGrantPaymentAmt = Float(R_VA_IndivProvAuxGrantPaymentAmt.calculate manager)
   R_VA_CoupleProvAuxGrantPaymentAmt = WebCalc.find_by_name('R_VA_CoupleProvAuxGrantPaymentAmt')
   R_VA_CoupleProvAuxGrantPaymentAmt = Float(R_VA_CoupleProvAuxGrantPaymentAmt.calculate manager)
   if VA_LiveInAuxGrantFacility == 'Yes' then
     R_VA_IndivProvAuxGrantPaymentAmt
   elsif VA_LiveWithSpouseAuxGrantFacility == 'Yes' then
     R_VA_CoupleProvAuxGrantPaymentAmt
   else
     0.00   
   end
    "
    @R_VA_ProvAuxGrantPaymentAmt.save!
  end

  def self.down
  end
end
