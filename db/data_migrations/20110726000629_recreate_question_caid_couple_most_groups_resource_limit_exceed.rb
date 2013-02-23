class RecreateQuestionCaidCoupleMostGroupsResourceLimitExceed < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager' 

       # 27 39 40 41 45 47 48 50	82	Do you and your spouse have countable resources that exceed the ~RateCoupleCaidMostGroupsResourceLimit~ Medicaid resource limit? (Include any deemed resources.)	
       #CaidCoupleMostGroupsResourceLimitExceed			YES:NO		NO	If (((CaidGet = YES AND VA_CaidGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy (Spendown)))  OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR 300% SSI OR Medically Needy (Spendown)))) AND LiveWithSpouse = Y) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  300% SSI AND AND LiveWithSpouse = N)	no		See M0530.200 -- A married individual living with his/her spouse is always an ABD couple assistance unit (2 persons) for the resource eligibility determination.  If user gets 300% SSI Medicaid (in an institution or has a Waiver) then user is assistance unit of one.  If use is married and applying for 300 % SSI -- Waiver or institution -- then assistance unit is 2.	87.00
       
         @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
          @CaidCoupleMostGroupsResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidCoupleMostGroupsResourceLimitExceed']) 

         if @CaidCoupleMostGroupsResourceLimitExceed.blank? then
            @CaidCoupleMostGroupsResourceLimitExceed = Question.new(:name => 'CaidCoupleMostGroupsResourceLimitExceed', :text => 'CaidCoupleMostGroupsResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.00',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 4 , :group_id => @QuestionGroup.id) 
         end

         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ Medicaid resource limit? (Include any equity in real estate contiguous to your home over the ~ limit and in any other real property)") 
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:default_answer, "No")
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:question_type, "select") 
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:question_order, "4")
         @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:workbook_order, "87") 

         #81
          # If ((((CaidGet = YES 
                #AND VA_CaidGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child 
                #OR 300% SSI OR Medically Needy(Spendown)))  
                #OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant 
                #OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy(Spendown)))) AND LiveWithSpouse <> YES)

          #82  If (((CaidGet = YES 
                #AND VA_CaidGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child 
                #OR Medically Needy (Spendown)))  {bob note 300 % group is always single rate per workbook except when applying}
                #OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant 
                #OR Adult Disabled Child OR Protected SSI Disabled Child OR 300% SSI OR Medically Needy (Spendown)))) AND LiveWithSpouse = Y) OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  300% SSI AND AND LiveWithSpouse = N)
          


     @CaidCoupleMostGroupsResourceLimitExceed.update_attribute(:display_rules, "
       CaidGet = manager.get_answer_by_question_name('CaidGet')
       VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
       CaidApply = manager.get_answer_by_question_name('CaidApply')
       VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
       LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
       (( CaidGet == 'Yes' && 
        (VA_CaidGetCoveredGroup == 'SSI Recipient' || VA_CaidGetCoveredGroup == '1619b (SSI Medicaid while working)' || VA_CaidGetCoveredGroup == 'Auxiliary Grant' ||
         VA_CaidGetCoveredGroup == 'Adult Disabled Child' || VA_CaidGetCoveredGroup == 'Protected SSI Disabled Child'  || 
          VA_CaidGetCoveredGroup == 'Medically Needy(Spendown)' )) ||
        ( CaidApply == 'Yes' && 
         (VA_CaidApplyCoveredGroup == 'SSI Recipient' || VA_CaidApplyCoveredGroup == '1619b (SSI Medicaid while working)' || VA_CaidApplyCoveredGroup == 'MEDICAID WORKS' ||
          VA_CaidApplyCoveredGroup == 'Auxiliary Grant' || 
          VA_CaidApplyCoveredGroup == 'Adult Disabled Child' || VA_CaidApplyCoveredGroup == 'Protected SSI Disabled Child'  || VA_CaidApplyCoveredGroup == '300% SSI' ||
          VA_CaidApplyCoveredGroup == 'Medically Needy(Spendown)')) && LiveWithSpouse == 'Yes')  || (CaidApply == 'Yes' && VA_CaidApplyCoveredGroup == '300% SSI'  && LiveWithSpouse == 'No')")


    #     #This is not the best way to add a new calc but i forgot this calc does not exist yet
    #       @RateCoupleCaidMostGroupsResourceLimit = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')
    #       if @RateCoupleCaidMostGroupsResourceLimit.blank? then
    #         @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.new(:name => 'RateCoupleCaidMostGroupsResourceLimit')
    #       end
    #
    #        @RateCoupleCaidMostGroupsResourceLimit.operation = "
    #        unless manager.get_answer_by_question_name('SitDate').blank? 
    #       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
    #               rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
    #              RateCoupleCaidMostGroupsResourceLimit = rate.RateCoupleCaidMostGroupsResourceLimit
    #          else
    #             RateCoupleCaidMostGroupsResourceLimit =  2000
    #          end
    #         "
    #         @RateCoupleCaidMostGroupsResourceLimit.save!

           # calc to insert
           @RateCoupleCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCoupleCaidMostGroupsResourceLimit')

           unless @RateCoupleCaidMostGroupsResourceLimit.blank?

              @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidCoupleMostGroupsResourceLimitExceed.id, 1])
              if @Insert1.blank? then
                 @Insert1  = QuestionInsert.new(:question_id => @CaidCoupleMostGroupsResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
                 @Insert1.save!
             else
               @Insert1.update_attribute(:question_id, @CaidCoupleMostGroupsResourceLimitExceed.id) 
               @Insert1.update_attribute(:insert_number, '1')
               @Insert1.update_attribute(:webcalc_id_to_insert, @RateCoupleCaidMostGroupsResourceLimit.id) 
               @Insert1.update_attribute(:insert_marker, '~')
               @Insert1.update_attribute(:insert_type, 'currency')
              end
           end

           #2nd calc to insert
          @VA_RateCaidRealEstateResourceLimit  = WebCalc.find_by_name('VA_RateCaidRealEstateResourceLimit')
          unless @VA_RateCaidRealEstateResourceLimit.blank?

            @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidCoupleMostGroupsResourceLimitExceed.id, 2])
            if @Insert2.blank? then
               @Insert2  = QuestionInsert.new(:question_id => @CaidCoupleMostGroupsResourceLimitExceed.id, :insert_number => '2', :webcalc_id_to_insert => @VA_RateCaidRealEstateResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
               @Insert2.save!
           else
             @Insert2.update_attribute(:question_id, @CaidCoupleMostGroupsResourceLimitExceed.id) 
             @Insert2.update_attribute(:insert_number, '2')
             @Insert2.update_attribute(:webcalc_id_to_insert, @VA_RateCaidRealEstateResourceLimit.id) 
             @Insert2.update_attribute(:insert_marker, '~')
             @Insert2.update_attribute(:insert_type, 'currency')
            end

         end
  end

  def self.down
  end
end
