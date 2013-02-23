class UpdateQuestionVaCaidSpouseGetCoveredGroupForAllowableAnswer < ActiveRecord::Migration
  def self.up
    
   require 'wwweb_session_manager'  
    #29 45 47	54	Under what Covered Group does your spouse have Medicaid Coverage?	VA_CaidSpouseGetCoveredGroup			SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:300% SSI:Medically Needy (Spendown)		IF SpouseSsiGet = Y THEN SSI Recipient, ELSE 80% FPL	If CaidSpouseGet = Y AND (CaidGet = Y OR CaidApply = Y)	no		In this version we only consider disablity-related Medicaid, not welfare-related Medicaid.  The addition in the appearance rules of the requirement that user must be getting or applying for Medicaid restricts the spousal Medicaid calcs from having to deal with deeming from user to spouse, or from a parent to a spouse.	55.00
 
     #VA_CaidSpouseGetCoveredGroup question edit to add insert marker
     @VA_CaidSpouseGetCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseGetCoveredGroup']) 

     @VA_CaidSpouseGetCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, 300% SSI, Medically Needy(Spendown)") unless @VA_CaidSpouseGetCoveredGroup.blank?

  end

  def self.down
  end
end
