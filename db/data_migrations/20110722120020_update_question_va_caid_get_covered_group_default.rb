class UpdateQuestionVaCaidGetCoveredGroupDefault < ActiveRecord::Migration
  def self.up
     
    require 'wwweb_session_manager'   
    @VA_CaidGetCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidGetCoveredGroup'])  
     
     #EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (LiveWithSpouseInFacility = Y OR LiveInFacility = Y), THEN 300% SSI, ELSE 80% FPL
     
      @VA_CaidGetCoveredGroup.update_attribute(:default_answer, "expression= 
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
      LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
      if SsiGet == 'Yes' then
        answer = 'SSI Recipient'
      elsif (LiveWithSpouseInFacility == 'Yes' || LiveInFacility == 'Yes') then
        answer = '300% SSI'
      else 
        answer = '80% FPL'
      end
      ") unless @VA_CaidGetCoveredGroup.blank?
  end

  def self.down
  end
end
