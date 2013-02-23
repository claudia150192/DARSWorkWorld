class CreateRTotCountIncFbrExceedAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

       #240	RTotCountIncFBRExceedAmt = IF R_SsiSpousalDeemCalcsUsed = FALSE, THEN R_TotalIncMinusBwePassNoSpouseDeemAmt - R_FbrNoSpouseDeemAmt, ELSE R_TotalIncMinusBwePassSpouseDeemAmt - R_FbrSpouseDeemAmt (not < 0)	RTotCountIncFBRExceedAmt
    #Bah, needed to redo so we delte it first
   @RTotCountIncFBRExceedAmt = WebCalc.find_by_name('RTotCountIncFBRExceedAmt') 
   @RTotCountIncFBRExceedAmt.delete unless @RTotCountIncFBRExceedAmt.blank?  
        
     @RTotCountIncFBRExceedAmt  = WebCalc.new(:name => 'RTotCountIncFBRExceedAmt')
     @RTotCountIncFBRExceedAmt.operation = "
    
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = (R_SsiSpousalDeemCalcsUsed.calculate manager)
    
    R_TotalIncMinusBwePassNoSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBwePassNoSpouseDeemAmt')
    R_TotalIncMinusBwePassNoSpouseDeemAmt = Float(R_TotalIncMinusBwePassNoSpouseDeemAmt.calculate manager)
    
    R_FbrNoSpouseDeemAmt = WebCalc.find_by_name('R_FbrNoSpouseDeemAmt')
    R_FbrNoSpouseDeemAmt = Float(R_FbrNoSpouseDeemAmt.calculate manager)
    
    R_TotalIncMinusBwePassSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBwePassSpouseDeemAmt')
    R_TotalIncMinusBwePassSpouseDeemAmt = Float(R_TotalIncMinusBwePassSpouseDeemAmt.calculate manager)
    
    R_FbrSpouseDeemAmt = WebCalc.find_by_name('R_FbrSpouseDeemAmt')
    R_FbrSpouseDeemAmt = Float(R_FbrSpouseDeemAmt.calculate manager)
    
    if R_SsiSpousalDeemCalcsUsed == false  then
      [R_TotalIncMinusBwePassNoSpouseDeemAmt - R_FbrNoSpouseDeemAmt, 0].max
    else
      [R_TotalIncMinusBwePassSpouseDeemAmt - R_FbrSpouseDeemAmt, 0].max
    end
     "
     @RTotCountIncFBRExceedAmt.save!
  end

  def self.down
  end
end
