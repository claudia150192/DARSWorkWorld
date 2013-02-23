class CreateQuestionCaidSpouseCoupleQmbSlmbQiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager' 

     #45	82.65	Do you and your spouse have countable resources that exceed the <RateCoupleQmbSlmbQiResouceLimit> resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)	
     #  CaidSpouseCoupleQmbSlmbQiResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = Different AND  ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = (QMB OR SLMB OR = QI))  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y	no			87.70
         
       @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed']) 

       if @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.blank? then
          @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed', :text => 'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.65',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 12 , :group_id => @QuestionGroup.id) 
       end

       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)") 
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:default_answer, "No")
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_type, "select") 
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_order, "13")
       @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.7") 

      @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
      R_VA_CaidUserSpouseSameCovGroup =  'this needs an edit, talked to DR on June 21'
      R_VA_CaidUserSpouseSameCovGroup == 'this needs an edit, talked to DR on June 21'")

      #this should be found
        @RateCoupleQmbSlmbQiResouceLimit = WebCalc.find_by_name('RateCoupleQmbSlmbQiResouceLimit')
      
      #this has been added so should not execute but just in case for completeness later on
        if @RateCoupleQmbSlmbQiResouceLimit.blank? then
          @RateCoupleQmbSlmbQiResouceLimit  = WebCalc.new(:name => 'RateCoupleQmbSlmbQiResouceLimit')
        end
  
       @RateCoupleQmbSlmbQiResouceLimit.operation = "
        unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
               rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
              RateCoupleQmbSlmbQiResouceLimit = rate.RateCoupleQmbSlmbQiResouceLimit
          else
             RateCoupleQmbSlmbQiResouceLimit =  6000
          end
       "
          @RateCoupleQmbSlmbQiResouceLimit.save!
  
      # calc to insert
      @RateCoupleQmbSlmbQiResouceLimit  = WebCalc.find_by_name('RateCoupleQmbSlmbQiResouceLimit')
  
      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id, 1])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQmbSlmbQiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id)
       @Insert2.update_attribute(:insert_number, '1')
       @Insert2.update_attribute(:webcalc_id_to_insert, @RateCoupleQmbSlmbQiResouceLimit.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
    
  end

  def self.down
  end
end
