class UpdateQuestionVaSpouseLiveInAuxGrantFacilityDisplayRule < ActiveRecord::Migration
  def self.up
    
    #45 51	51.5	Does your spouse live in a facility or foster care supported by an Auxiliary Grant?	VA_SpouseLiveInAuxGrantFacility			YES:NO		NO	If SpouseLiveInFacility = Y AND SsiGet = Y AND CaidSpouseGet = Y AND State = VA	no		If user does not get Aux grant and spouse does, then we ask this question only to give the spouse a Tip and TR saying that spouse must enter data as user in order to determine aux grant eligibility and payment amount.		52.25
    
     @VA_SpouseLiveInAuxGrantFacility = Question.find(:first, :conditions => ['name = ?',  'VA_SpouseLiveInAuxGrantFacility']) 
    
    #If SpouseLiveInFacility = Y AND SsiGet = Y AND CaidSpouseGet = Y AND State = VA
    
      @VA_SpouseLiveInAuxGrantFacility.update_attribute(:display_rules, "
      SpouseLiveInFacility = manager.get_answer_by_question_name('SpouseLiveInFacility')
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
      State = manager.get_answer_by_question_name('State')
      (SpouseLiveInFacility == 'Yes' && SsiGet == 'Yes' && CaidSpouseGet == 'Yes' && State == 'Virginia')") unless @VA_SpouseLiveInAuxGrantFacility.blank?
  end

  def self.down
  end
end
