class UpdateQuestionVaCaidSpouseApplyCoveredGroupForAllowableAnswer < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
     #29 45 47	56	For what Covered Group is your spouse applying for Medicaid Coverage?	VA_CaidSpouseApplyCoveredGroup			SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:300% SSI:Medically Needy (Spendown)		80% FPL	If CaidSpouseApply = Y AND (CaidGet = Y OR CaidApply = Y)	no		If user answers that spouse is in Medical Institution or Waiver, then a Tip should explain about Community Spouse resources in applying for Long Term Care Medicaid.	57.00
     
      #VA_CaidSpouseApplyCoveredGroup question edit to add insert marker
      @VA_CaidSpouseApplyCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseApplyCoveredGroup']) 

      @VA_CaidSpouseApplyCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, 300% SSI, Medically Needy(Spendown)") unless @VA_CaidSpouseApplyCoveredGroup.blank?

  end

  def self.down
  end
end
