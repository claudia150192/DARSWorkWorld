class RecreateQuestionCaidApplyLtcCommunitySpouseResourceLimitExceed < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
 
  #bad goof and learned that these migrations do not apply the model rules. First redo added a question with the same name.  Will re-run this with a redo and deleting all occurances first
   @CaidApplyLtcCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidApplyLtcCommunitySpouseResourceLimitExceed']) 
 
  if !(@CaidApplyLtcCommunitySpouseResourceLimitExceed.blank?)  then
     @CaidApplyLtcCommunitySpouseResourceLimitExceed.delete
  end
 
 
    #45 48 49	82.45	Do your spouse's excess resources (the amount greater than PRA) plus your own resources exceed the ~RateCaidMostGroupsResourceLimit~ resource limit?	
    #CaidApplyLtcCommunitySpouseResourceLimitExceed			YES:NO		NO	IF CaidApplyLtcCommunitySpousePraExceed = YES	no		See M1480.232.  A TIP should tell user how PRA is established and that it is used only in the application process.  After eligibility is established, only the individual's resources are counted.	87.50
    
      @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
      @CaidApplyLtcCommunitySpouseResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidApplyLtcCommunitySpouseResourceLimitExceed']) 
 
      
      if @CaidApplyLtcCommunitySpouseResourceLimitExceed.blank? then
         @CaidApplyLtcCommunitySpouseResourceLimitExceed = Question.new(:name => 'CaidApplyLtcCommunitySpouseResourceLimitExceed', :text => 'CaidApplyLtcCommunitySpouseResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.45',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 14, :group_id => @QuestionGroup.id) 
      end
 
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:text, "Do your spouse's excess resources (the amount greater than PRA) plus your own resources exceed the ~ resource limit?") 
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:default_answer, "No")
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:question_type, "select") 
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:question_order, "14")
      @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:workbook_order, "87.5") 
 
     #   IF CaidApplyLtcCommunitySpousePraExceed = YES
       @CaidApplyLtcCommunitySpouseResourceLimitExceed.update_attribute(:display_rules, "
        CaidApplyLtcCommunitySpousePraExceed = manager.get_answer_by_question_name('CaidApplyLtcCommunitySpousePraExceed')
        (CaidApplyLtcCommunitySpousePraExceed == 'Yes')")
    
        # calc to insert
         @RateCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')
    
      unless @RateCaidMostGroupsResourceLimit.blank?
 
         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidApplyLtcCommunitySpouseResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @CaidApplyLtcCommunitySpouseResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @CaidApplyLtcCommunitySpouseResourceLimitExceed.id) 
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RateCaidMostGroupsResourceLimit.id) 
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
       end
  end

  def self.down
  end
end
