class RecreateQuestionCaidQdwiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    
    #  40 41 50	82.1	Do you have countable resources that exceed the ~RateQwdiResouceLimit~ QDWI Medicaid resource limit? (Include any deemed resources.)	
      #CaidQdwiResourceLimitExceed			YES:NO		NO	If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup =  QDWI)) AND LiveWithSpouse <> YES N	no			87.10
 
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @CaidQdwiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidQdwiResourceLimitExceed']) 
 
      if @CaidQdwiResourceLimitExceed.blank? then
         @CaidQdwiResourceLimitExceed = Question.new(:name => 'CaidQdwiResourceLimitExceed', :text => 'CaidQdwiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.1',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 9, :group_id => @QuestionGroup.id) 
      end
 
      @CaidQdwiResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ QDWI Medicaid resource limit? (Include any deemed resources.)") 
      @CaidQdwiResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidQdwiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidQdwiResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidQdwiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidQdwiResourceLimitExceed.update_attribute(:question_order, "9")
      @CaidQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.10") 
 
     #  If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup =  QDWI)) AND LiveWithSpouse <> YES N
     @CaidQdwiResourceLimitExceed.update_attribute(:display_rules, "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        ((( CaidGet == 'Yes' && VA_CaidGetCoveredGroup == 'QDWI') || ( CaidApply == 'Yes' && VA_CaidApplyCoveredGroup == 'QDWI')) && LiveWithSpouse != 'Yes')")
     
      # calc to insert
      @RateQwdiResouceLimit  = WebCalc.find_by_name('RateQwdiResouceLimit')
 
      unless @RateQwdiResouceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidQdwiResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidQdwiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateQwdiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidQdwiResourceLimitExceed.id) 
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RateQwdiResouceLimit.id) 
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
       end
  end

  def self.down
  end
end
