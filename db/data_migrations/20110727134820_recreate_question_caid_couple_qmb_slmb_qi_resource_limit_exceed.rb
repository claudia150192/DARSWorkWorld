class RecreateQuestionCaidCoupleQmbSlmbQiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    
      #40 41 45	82.4	Do you and your spouse have countable resources that exceed the ~RateCoupleQmbSlmbQiResouceLimit~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)	
      #CaidCoupleQmbSlmbQiResourceLimitExceed			YES:NO		NO	If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI))  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y	Appear	NO		87.40
      
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @CaidCoupleQmbSlmbQiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidCoupleQmbSlmbQiResourceLimitExceed']) 
 
      if @CaidCoupleQmbSlmbQiResourceLimitExceed.blank? then
         @CaidCoupleQmbSlmbQiResourceLimitExceed = Question.new(:name => 'CaidCoupleQmbSlmbQiResourceLimitExceed', :text => 'CaidCoupleQmbSlmbQiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.4',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 12, :group_id => @QuestionGroup.id) 
      end
 
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.)") 
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:question_order, "12")
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.40") 
 
     #  If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI))  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        ((( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QMB' || VA_CaidGetCoveredGroup == 'SLMB' || VA_CaidGetCoveredGroup == 'QI')) ||
         ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QMB' || VA_CaidApplyCoveredGroup == 'SLMB' || VA_CaidApplyCoveredGroup == 'QI'))) && LiveWithSpouse == 'Yes')")
     
      # calc to insert
      @RateCoupleQmbSlmbQiResouceLimit  = WebCalc.find_by_name('RateCoupleQmbSlmbQiResouceLimit')
 
      unless @RateCoupleQmbSlmbQiResouceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidCoupleQmbSlmbQiResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidCoupleQmbSlmbQiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQmbSlmbQiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidCoupleQmbSlmbQiResourceLimitExceed.id) 
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
