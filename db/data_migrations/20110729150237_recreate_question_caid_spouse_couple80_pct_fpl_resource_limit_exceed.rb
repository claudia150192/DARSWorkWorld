class RecreateQuestionCaidSpouseCouple80PctFplResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    
     require 'wwweb_session_manager'  
     #48 51	82.57	Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~RateCoupleCaidMostGroupsResourceLimit~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)	
     #CaidSpouseCouple80PctFplResourceLimitExceed			YES:NO		NO	If  R_VA_CaidUserSpouseSameCovGroup = FALSE AND (CaidSpouseGet = YES AND VA_CaidSpouseGetCoveredGroup =  80% FPL) OR (CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup = 80% FPL) AND LiveWithSpouse = YES)	no		The 80% FPL covered group goes by federal rules for home ownership and continguous land.  See Appendix 2 of S11.  So the $5,000 limit on contiguous proerty does not apply.		87.62
     
     
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCouple80PctFplResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCouple80PctFplResourceLimitExceed']) 


        if @CaidSpouseCouple80PctFplResourceLimitExceed.blank? then
           @CaidSpouseCouple80PctFplResourceLimitExceed = Question.new(:name => 'CaidSpouseCouple80PctFplResourceLimitExceed', :text => 'CaidSpouseCouple80PctFplResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.57',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 17, :group_id => @QuestionGroup.id) 
        end

        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:text, "Spouse Resource Eligibility: Do you and your spouse have countable resources that exceed the ~ Medicaid resource limit? (Do not include your share of any equity in real estate contiguous to your home.)") 
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:default_answer, "No")
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:question_type, "select") 
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:question_order, "17")
        @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:workbook_order, "87.62") 

       #  If  R_VA_CaidUserSpouseSameCovGroup = FALSE AND (CaidSpouseGet = YES AND VA_CaidSpouseGetCoveredGroup =  80% FPL) OR (CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup = 80% FPL) AND LiveWithSpouse = YES)
       
       
       @CaidSpouseCouple80PctFplResourceLimitExceed.update_attribute(:display_rules, "
        R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
        R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
         CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
         VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
         VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
         LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
         CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
         (R_VA_CaidUserSpouseSameCovGroup == false && ((CaidSpouseGet == 'Yes'  &&  (VA_CaidSpouseGetCoveredGroup == '80% FPL'))  || 
          (CaidSpouseApply == 'Yes'  && (VA_CaidSpouseGetCoveredGroup == '80% FPL') && LiveWithSpouse == 'Yes' )))")
       
   
        # calc to insert
           @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')

        unless @RateCoupleCaidMostGroupsResourceLimit.blank?

           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCouple80PctFplResourceLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @CaidSpouseCouple80PctFplResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @CaidSpouseCouple80PctFplResourceLimitExceed.id) 
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
