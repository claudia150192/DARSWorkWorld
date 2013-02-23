class RecreateQuestionCaidSpouseCoupleMostGroupsResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

      #45 47 48 50	82.55	Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~RateCoupleCaidMostGroupsResourceLimit~ Medicaid resource limit? (Include any deemed resources.)	
      #CaidSpouseCoupleMostGroupsResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND (((CaidSpouseGet = YES AND VA_CaidSpouseGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy (Spendown)))  OR (CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR 300% SSI OR Medically Needy (Spendown)))) AND LiveWithSpouse = Y) OR (CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup =  300% SSI AND AND LiveWithSpouse = N)	Appear	NO	This and the next few questions ask about spouse resources if the user and spouse are not in or applying for same covered group.	87.60
      
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleMostGroupsResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleMostGroupsResourceLimitExceed']) 


        if @CaidSpouseCoupleMostGroupsResourceLimitExceed.blank? then
           @CaidSpouseCoupleMostGroupsResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleMostGroupsResourceLimitExceed', :text => 'CaidSpouseCoupleMostGroupsResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.55',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 16, :group_id => @QuestionGroup.id) 
        end

        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ Medicaid resource limit? (Include any deemed resources.)") 
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:default_answer, "No")
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:question_type, "select") 
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:question_order, "16")
        @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:workbook_order, "87.6") 

       # IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND (((CaidSpouseGet = YES AND 
       # VA_CaidSpouseGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy (Spendown)))  
       #OR (CaidSpouseApply = YES 
       #AND VA_CaidSpouseApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR 300% SSI OR Medically Needy (Spendown)))) AND LiveWithSpouse = Y) 
       #OR (CaidSpouseApply = YES AND VA_CaidSpouseApplyCoveredGroup =  300% SSI AND AND LiveWithSpouse = N)
       
       @CaidSpouseCoupleMostGroupsResourceLimitExceed.update_attribute(:display_rules, "
        R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
        R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
         CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
         VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
         VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
         LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
         CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
         (R_VA_CaidUserSpouseSameCovGroup == false && ((CaidSpouseGet == 'Yes'  && 
          (VA_CaidSpouseGetCoveredGroup == 'SSI Recipient' || VA_CaidSpouseGetCoveredGroup == 'SSI Recipient' || VA_CaidSpouseGetCoveredGroup == '1619b (SSI Medicaid while working)' || 
          VA_CaidSpouseGetCoveredGroup == 'MEDICAID WORKS' || VA_CaidSpouseGetCoveredGroup == 'Auxiliary Grant' || VA_CaidSpouseGetCoveredGroup == 'Adult Disabled Child' || VA_CaidSpouseGetCoveredGroup == 'Protected SSI Disabled Child' ||
          VA_CaidSpouseGetCoveredGroup == '300% SSI' || VA_CaidSpouseGetCoveredGroup == 'Medically Needy (Spendown)'))  || 
          (CaidSpouseApply == 'Yes'  &&
          (VA_CaidSpouseGetCoveredGroup == 'SSI Recipient' || VA_CaidSpouseGetCoveredGroup == 'SSI Recipient' || VA_CaidSpouseGetCoveredGroup == '1619b (SSI Medicaid while working)' || 
           VA_CaidSpouseGetCoveredGroup == 'MEDICAID WORKS' || VA_CaidSpouseGetCoveredGroup == 'Auxiliary Grant' || VA_CaidSpouseGetCoveredGroup == 'Adult Disabled Child' || VA_CaidSpouseGetCoveredGroup == 'Protected SSI Disabled Child' ||
           VA_CaidSpouseGetCoveredGroup == '300% SSI' || VA_CaidSpouseGetCoveredGroup == 'Medically Needy (Spendown)') && LiveWithSpouse == 'Yes' ))  ||
           (CaidSpouseApply == 'Yes' && VA_CaidSpouseApplyCoveredGroup ==  '300% SSI' && LiveWithSpouse == 'No')
            )")
       
   
        # calc to insert
           @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')

        unless @RateCoupleCaidMostGroupsResourceLimit.blank?

           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleMostGroupsResourceLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @CaidSpouseCoupleMostGroupsResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @CaidSpouseCoupleMostGroupsResourceLimitExceed.id) 
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