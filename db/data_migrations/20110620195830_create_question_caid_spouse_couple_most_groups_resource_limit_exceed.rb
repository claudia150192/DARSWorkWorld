class CreateQuestionCaidSpouseCoupleMostGroupsResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager' 

     # 45	82.55	Do you and your spouse have countable resources that exceed the <RateCoupleCaidMostGroupsResourceLimit> Medicaid resource limit? (Include any deemed resources.)	CaidSpouseCoupleMostGroupsResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = Different AND (((CaidSpouseGet = YES AND VA_CaidSpouseGetCoveredGroup <> (QDWI OR QMB OR SLMB OR QI OR MEDICAID WORKS))  OR ((CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup <>  (QDWI OR QMB OR SLMB OR QI OR Medical Institution)) AND LiveWithSpouse = Y AND VA_CaidSpouseApplyCoveredGroup = Waiver)))	Appear	YES	This and the next few questions ask about spouse resources if the user and spouse are not in or applying for same covered group.	87.60
     
       @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleMostGroupsResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleMostGroupsResourceLimitExceed']) 

       if @CaidSpouseCoupleMostGroupsResourceLimitExceed.blank? then
          @CaidSpouseCoupleMostGroupsResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleMostGroupsResourceLimitExceed', :text => 'CaidSpouseCoupleMostGroupsResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.55',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 11 , :group_id => @QuestionGroup.id) 
       end

       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ Medicaid resource limit? (Include any deemed resources.)") 
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:default_answer, "No")
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:question_type, "select") 
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:question_order, "11")
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:workbook_order, "87.60") 

      #  IF R_VA_CaidUserSpouseSameCovGroup = Different AND (((CaidSpouseGet = YES AND VA_CaidSpouseGetCoveredGroup <> (QDWI OR QMB OR SLMB OR QI OR MEDICAID WORKS))  
      #  OR ((CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup <>  (QDWI OR QMB OR SLMB OR QI OR Medical Institution)) AND LiveWithSpouse = Y AND VA_CaidSpouseApplyCoveredGroup = Waiver)))
      #Bah, this refewrs to calcs that are not yet completed, i guess i will bail for now and say help?
      
      #RAge = WebCalc.find_by_name('RAge')
      #Age = Float(RAge.calculate manager)

      @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:display_rules, "
      R_VA_CaidUserSpouseSameCovGroup =  'this needs an edit, talked to DR on June 21'
      R_VA_CaidUserSpouseSameCovGroup == 'this needs an edit, talked to DR on June 21'")

    #note this webcalc is referring to a rate that needs to be fixed in the rate table, name has changed

      #This is not the best way to add a new calc but i forgot this calc does not exist yet
        @RateCoupleCaidMostGroupsResourceLimit = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')
        if @RateCoupleCaidMostGroupsResourceLimit.blank? then
          @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.new(:name => 'RateCoupleCaidMostGroupsResourceLimit')
        end
  
         @RateCoupleCaidMostGroupsResourceLimit.operation = "
         unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
                rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
               RateCoupleCaidMostGroupsResourceLimit = rate.RateCoupleCaidMostGroupsResourceLimit
           else
              RateCoupleCaidMostGroupsResourceLimit =  3000
           end
          "
          @RateCoupleCaidMostGroupsResourceLimit.save!
  
      # calc to insert
      @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')
  
      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleMostGroupsResourceLimitExceed.id, 1])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @CaidSpouseCoupleMostGroupsResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @CaidSpouseCoupleMostGroupsResourceLimitExceed.id)
       @Insert2.update_attribute(:insert_number, '1')
       @Insert2.update_attribute(:webcalc_id_to_insert, @RateCoupleCaidMostGroupsResourceLimit.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
  end

  def self.down
  end
end
