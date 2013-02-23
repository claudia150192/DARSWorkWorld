class RecreateQuestionCaidSpouseCoupleQmbSlmbQiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
      #45 47 48	82.65	Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~RateCoupleQmbSlmbQiResouceLimit~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)	
      #CaidSpouseCoupleQmbSlmbQiResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND  ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = (QMB OR SLMB OR = QI))  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y	no				87.70
      
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed']) 


        if @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.blank? then
           @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed', :text => 'CaidSpouseCoupleQmbSlmbQiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.65',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 19, :group_id => @QuestionGroup.id) 
        end

        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:text, "Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)") 
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:default_answer, "No")
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_type, "select") 
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_order, "19")
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.70") 

        #IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND  ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = (QMB OR SLMB OR = QI))  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y
        
        @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
      R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
      R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
       CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
       VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
       VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
       LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
       CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
       (R_VA_CaidUserSpouseSameCovGroup == false && ((CaidSpouseGet == 'Yes'  &&  (VA_CaidSpouseGetCoveredGroup == 'QMB'  || VA_CaidSpouseGetCoveredGroup == 'SLMB' || VA_CaidSpouseGetCoveredGroup == 'QI'))  || 
        (CaidSpouseApply == 'Yes'  && (VA_CaidSpouseGetCoveredGroup == 'QMB' || VA_CaidSpouseGetCoveredGroup == 'SLMB' || VA_CaidSpouseGetCoveredGroup == 'QI'))) && LiveWithSpouse == 'Yes')")
          
        # calc to insert
           @RateCoupleQmbSlmbQiResouceLimit  = WebCalc.find_by_name('RateCoupleQmbSlmbQiResouceLimit')

        unless @RateCoupleQmbSlmbQiResouceLimit.blank?

           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQmbSlmbQiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @CaidSpouseCoupleQmbSlmbQiResourceLimitExceed.id) 
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RateCoupleQmbSlmbQiResouceLimit.id) 
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end
         end
  end

  def self.down
  end
end
