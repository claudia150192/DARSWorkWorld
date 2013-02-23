class RecreateQuestionCaidCouple80PctFplResourceLimitExceed < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager' 

       #48	82.02	Do you and your spouse have countable resources that exceed the ~RateCoupleCaidMostGroupsResourceLimit~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)	
       #CaidCouple80PctFplResourceLimitExceed			YES:NO		NO	If (CaidGet = YES AND VA_CaidGetCoveredGroup =  80% FPL) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup = 80% FPL) AND LiveWithSpouse = YES)	no		The 80% FPL covered group goes by federal rules for home ownership and continguous land.  See Appendix 2 of S11.  So the $5,000 limit on contiguous proerty does not apply.	87.04
       
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
         @CaidCouple80PctFplResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidCouple80PctFplResourceLimitExceed']) 
 
        if @CaidCouple80PctFplResourceLimitExceed.blank? then
           @CaidCouple80PctFplResourceLimitExceed = Question.new(:name => 'CaidCouple80PctFplResourceLimitExceed', :text => 'CaidCouple80PctFplResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.02',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 6 , :group_id => @QuestionGroup.id) 
        end
 
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)") 
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:default_answer, "No")
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:question_type, "select") 
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:question_order, "6")
        @CaidCouple80PctFplResourceLimitExceed.update_attribute(:workbook_order, "87.04") 
 
       #    If (CaidGet = YES AND VA_CaidGetCoveredGroup =  80% FPL) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup = 80% FPL) AND LiveWithSpouse = YES)
       
       @CaidCouple80PctFplResourceLimitExceed.update_attribute(:display_rules, "
         CaidGet = manager.get_answer_by_question_name('CaidGet')
         VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
         CaidApply = manager.get_answer_by_question_name('CaidApply')
         VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
         LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
         ((( CaidGet == 'Yes' && VA_CaidGetCoveredGroup == '80% FPL') || ( CaidApply == 'Yes' && VA_CaidApplyCoveredGroup == '80% FPL')) && LiveWithSpouse == 'Yes')")

        # calc to insert
        @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')

        unless @RateCoupleCaidMostGroupsResourceLimit.blank?

           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidCouple80PctFplResourceLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @CaidCouple80PctFplResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @CaidCouple80PctFplResourceLimitExceed.id) 
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RateCoupleCaidMostGroupsResourceLimit.id) 
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end
        end
  end

  def self.down
  end
end
