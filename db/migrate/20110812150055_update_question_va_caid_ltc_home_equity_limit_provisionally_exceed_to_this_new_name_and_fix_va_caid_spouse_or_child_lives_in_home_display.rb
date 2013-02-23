class UpdateQuestionVaCaidLtcHomeEquityLimitProvisionallyExceedToThisNewNameAndFixVaCaidSpouseOrChildLivesInHomeDisplay < ActiveRecord::Migration
  def self.up
    
    @VA_CaidLtcHomeEquityLimitExceed = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLtcHomeEquityLimitExceed']) 

   if !(@VA_CaidLtcHomeEquityLimitExceed.blank?) then
     @VA_CaidLtcHomeEquityLimitExceed.update_attribute(:name, "VA_CaidLtcHomeEquityLimitProvisionallyExceed") 
   end
  
  
    @VA_CaidSpouseOrChildLivesInHome = Question.find(:first, :conditions => ['name = ?',  'VA_CaidSpouseOrChildLivesInHome']) 

    if !(@VA_CaidSpouseOrChildLivesInHome.blank?) then

        @VA_CaidSpouseOrChildLivesInHome.update_attribute(:display_rules, "
        VA_CaidLtcHomeEquityLimitProvisionallyExceed = manager.get_answer_by_question_name('VA_CaidLtcHomeEquityLimitProvisionallyExceed')
        (VA_CaidLtcHomeEquityLimitProvisionallyExceed == 'Yes')")

    end
  
  
    
  end

  def self.down
  end
end
