class UpdateQuestionVaCaidGetCoveredGroupForAllowableAnswer < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
         #25 45 47	33	Virginia Medicaid: Under what Covered Group do you have Medicaid Coverage?	VA_CaidGetCoveredGroup
         #SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:300% SSI:Medically Needy (Spendown)		EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (LiveWithSpouseInFacility = Y OR LiveInFacility = Y), THEN Medical Institution, ELSE 80% FPL	If State = Virginia AND CaidGet = Y	no		If we add other states, they will have different covered groups.  I've added Jack Q's suggested wording on 1619b, removed Protected SSI Child.	31.00
         
          #VA_CaidGetCoveredGroup question edit to add insert marker
          @VA_CaidGetCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidGetCoveredGroup']) 

          @VA_CaidGetCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, 300% SSI, Medically Needy(Spendown)") unless @VA_CaidGetCoveredGroup.blank?
    
  end

  def self.down
  end
end
