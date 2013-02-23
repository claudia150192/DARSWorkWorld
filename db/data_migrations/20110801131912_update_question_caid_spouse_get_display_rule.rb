class UpdateQuestionCaidSpouseGetDisplayRule < ActiveRecord::Migration
  def self.up
    
    #29 45 51	53	Is your spouse currently covered by some type of Medicaid?	CaidSpouseGet			YES:NO		NO	If Married = Y AND (SpouseBlind = Y OR SpouseDisability = Y	Appear	YES	If user does not get and is not applying for Medicaid and spouse does get it, then we ask this question only to give the spouse a Tip and TR saying that spouse must enter data as user in order to determine Medicaid eligibility.		54.00
    
    @CaidSpouseGet = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseGet']) 
    
    #If Married = Y AND (SpouseBlind = Y OR SpouseDisability = Y
      
      @CaidSpouseGet.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
      SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
      Married == 'Yes' && (SpouseBlind ==  'Yes' || SpouseDisability ==  'Yes')
      ") unless @CaidSpouseGet.blank?
  end

  def self.down
  end
end
