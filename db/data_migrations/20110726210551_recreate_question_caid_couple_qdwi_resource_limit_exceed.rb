class RecreateQuestionCaidCoupleQdwiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
    
    # 40 41 45	82.2	Do you and your spouse have countable resources that exceed the ~RateCoupleQwdiResouceLimit~  QDWI Medicaid resource limit? (Include any deemed resources.)	
    #CaidCoupleQdwiResourceLimitExceed			YES:NO		NO	If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = QDWI)) AND LiveWithSpouse =Y	no			87.20
    
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
       @CaidCoupleQdwiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidCoupleQdwiResourceLimitExceed']) 
 
      if @CaidCoupleQdwiResourceLimitExceed.blank? then
         @CaidCoupleQdwiResourceLimitExceed = Question.new(:name => 'CaidCoupleQdwiResourceLimitExceed', :text => 'CaidCoupleQdwiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.2',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 10, :group_id => @QuestionGroup.id) 
      end
 
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ QDWI Medicaid resource limit? (Include any deemed resources.)") 
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:question_order, "10")
      @CaidCoupleQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.20") 
 
     #   If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = QDWI)) AND LiveWithSpouse =Y
     
     @CaidCoupleQdwiResourceLimitExceed.update_attribute(:display_rules, "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
        LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
        ((( CaidGet == 'Yes' && VA_CaidGetCoveredGroup == 'QDWI') || ( CaidApply == 'Yes' && VA_CaidApplyCoveredGroup == 'QDWI')) && LiveWithSpouse == 'Yes')")
     
      # calc to insert
      @RateCoupleQwdiResouceLimit  = WebCalc.find_by_name('RateCoupleQwdiResouceLimit')
 
      unless @RateCoupleQwdiResouceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidCoupleQdwiResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidCoupleQdwiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQwdiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidCoupleQdwiResourceLimitExceed.id) 
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RateCoupleQwdiResouceLimit.id) 
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
       end
  end

  def self.down
  end
end
