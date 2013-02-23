class CreateRvaAuxGrantPaymentAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

       #260	R_VA_AuxGrantPaymentAmt = R_VA_ProvAuxGrantPaymentAmt - RTotCountIncFBRExceedAmt (not < 0)	R_VA_AuxGrantPaymentAmt
    
        #Bah, needed to redo so we delte it first
        @R_VA_AuxGrantPaymentAmt = WebCalc.find_by_name('R_VA_AuxGrantPaymentAmt') 
        @R_VA_AuxGrantPaymentAmt.delete unless @R_VA_AuxGrantPaymentAmt.blank?
        
                  
     @R_VA_AuxGrantPaymentAmt  = WebCalc.new(:name => 'R_VA_AuxGrantPaymentAmt')
     @R_VA_AuxGrantPaymentAmt.operation = "
    R_VA_ProvAuxGrantPaymentAmt = WebCalc.find_by_name('R_VA_ProvAuxGrantPaymentAmt')
    R_VA_ProvAuxGrantPaymentAmt = Float(R_VA_ProvAuxGrantPaymentAmt.calculate manager)
    
    RTotCountIncFBRExceedAmt = WebCalc.find_by_name('RTotCountIncFBRExceedAmt')
    RTotCountIncFBRExceedAmt = Float(RTotCountIncFBRExceedAmt.calculate manager)
      
    [R_VA_ProvAuxGrantPaymentAmt - RTotCountIncFBRExceedAmt, 0].max
  "
     @R_VA_AuxGrantPaymentAmt.save!
  end

  def self.down
  end
end
