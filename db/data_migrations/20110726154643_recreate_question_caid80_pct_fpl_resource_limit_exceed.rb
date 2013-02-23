class RecreateQuestionCaid80PctFplResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager' 

        #48	82.01	Do you have countable resources that exceed the ~RateCaidMostGroupsResourceLimit~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)	
        #Caid80PctFplResourceLimitExceed			YES:NO		NO	If (CaidGet = YES AND VA_CaidGetCoveredGroup =  80% FPL) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup = 80% FPL) AND LiveWithSpouse <> YES)	no		The 80% FPL covered group goes by federal rules for home ownership and continguous land.  See Appendix 2 of S11.  So the $5,000 limit on contiguous proerty does not apply.	87.02
        
         @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
          @Caid80PctFplResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'Caid80PctFplResourceLimitExceed']) 

         if @Caid80PctFplResourceLimitExceed.blank? then
            @Caid80PctFplResourceLimitExceed = Question.new(:name => 'Caid80PctFplResourceLimitExceed', :text => 'Caid80PctFplResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.01',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 5 , :group_id => @QuestionGroup.id) 
         end

         @Caid80PctFplResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)") 
         @Caid80PctFplResourceLimitExceed.update_attribute(:default_answer, "No")
         @Caid80PctFplResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
         @Caid80PctFplResourceLimitExceed.update_attribute(:question_type, "select") 
         @Caid80PctFplResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
         @Caid80PctFplResourceLimitExceed.update_attribute(:question_order, "5")
         @Caid80PctFplResourceLimitExceed.update_attribute(:workbook_order, "87.02") 

     #If (CaidGet = YES AND VA_CaidGetCoveredGroup =  80% FPL) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup = 80% FPL) AND LiveWithSpouse <> YES)
    
     @Caid80PctFplResourceLimitExceed.update_attribute(:display_rules, "
       CaidGet = manager.get_answer_by_question_name('CaidGet')
       VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
       CaidApply = manager.get_answer_by_question_name('CaidApply')
       VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
       LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
       ((( CaidGet == 'Yes' && VA_CaidGetCoveredGroup == '80% FPL') || ( CaidApply == 'Yes' && VA_CaidApplyCoveredGroup == '80% FPL')) && LiveWithSpouse != 'Yes')")

      # calc to insert
      @RateCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')

      unless @RateCaidMostGroupsResourceLimit.blank?

         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @Caid80PctFplResourceLimitExceed.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @Caid80PctFplResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @Caid80PctFplResourceLimitExceed.id) 
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
