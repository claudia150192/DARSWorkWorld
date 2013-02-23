class UpdateQuestionVaCaidApplyCoveredGroupForAllowableAnswer < ActiveRecord::Migration
  def self.up
  
      require 'wwweb_session_manager'  
    #  25 47	35	Under what Virginia Covered Group are you applying for Medicaid coverage?	VA_CaidApplyCoveredGroup			SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:300% SSI:Medically Needy (Spendown)		80% FPL	IF State = Virginia AND CaidApply = Y	Appear	SSI Recipient		33.00
    
        #VA_CaidApplyCoveredGroup question edit to add insert marker
        @VA_CaidApplyCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidApplyCoveredGroup']) 
  
        @VA_CaidApplyCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, 300% SSI, Medically Needy(Spendown)") unless @VA_CaidApplyCoveredGroup.blank?
  
  end

  def self.down
  end
end
