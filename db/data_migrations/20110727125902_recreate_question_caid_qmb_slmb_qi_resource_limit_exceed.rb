class RecreateQuestionCaidQmbSlmbQiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
    
    #40 41 50	82.3	Do you have countable resources that exceed the ~RateQmbSlmbQiResouceLimit~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)	
    #CaidQmbSlmbQiResourceLimitExceed			YES:NO		NO	If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI)) OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR  SLMB OR QI))) AND LiveWithSpouse <> YES	no			87.30
    
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @CaidQmbSlmbQiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidQmbSlmbQiResourceLimitExceed']) 
 
      if @CaidQmbSlmbQiResourceLimitExceed.blank? then
         @CaidQmbSlmbQiResourceLimitExceed = Question.new(:name => 'CaidQmbSlmbQiResourceLimitExceed', :text => 'CaidQmbSlmbQiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.3',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 11, :group_id => @QuestionGroup.id) 
      end
 
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)") 
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:question_order, "11")
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.30") 
 
     #  If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI)) OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR  SLMB OR QI))) AND LiveWithSpouse <> YES
     @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        ((( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QMB' || VA_CaidGetCoveredGroup == 'SLMB' || VA_CaidGetCoveredGroup == 'QI')) ||
         ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QMB' || VA_CaidApplyCoveredGroup == 'SLMB' || VA_CaidApplyCoveredGroup == 'QI'))) && LiveWithSpouse != 'Yes')")
     
      # calc to insert
      @RateQmbSlmbQiResouceLimit  = WebCalc.find_by_name('RateQmbSlmbQiResouceLimit')
 
      unless @RateQmbSlmbQiResouceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidQmbSlmbQiResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidQmbSlmbQiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateQmbSlmbQiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidQmbSlmbQiResourceLimitExceed.id) 
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RateQmbSlmbQiResouceLimit.id) 
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
       end
  end

  def self.down
  end
end
