class UpdateQuestionSpouseDisabilityDisplayRuleForLiveWithSpouseChange < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #25	16	Does your spouse have a disability according to SSA criteria?	SpouseDisability			YES:NO		NO	IF SpouseBlind = N	Appear	YES		14.00
       
      #SpouseDisability question edit to add insert marker
      @SpouseDisability = Question.find(:first, :conditions => ['name = ?',  'SpouseDisability']) 
      @SpouseDisability.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
      Married == 'Yes' && SpouseBlind == 'No'
      ") 
 
  end

  def self.down
  end
end
