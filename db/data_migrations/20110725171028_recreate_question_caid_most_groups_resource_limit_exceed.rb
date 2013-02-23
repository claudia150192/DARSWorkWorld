class RecreateQuestionCaidMostGroupsResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager' 

     # 27 39 40 41 45 48	81	Do you have countable resources that exceed the ~RateCaidMostGroupsResourceLimit~ Medicaid resource limit? (Include your share of any equity in real estate contiguous to your home over the ~VA_RateCaidRealEstateResourceLimit~ limit and your share of any other real property)	
     #CaidMostGroupsResourceLimitExceed			YES:NO		NO	
     #If ((((CaidGet = YES AND VA_CaidGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR 300% SSI OR Medically Needy(Spendown)))  OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy(Spendown)))) AND LiveWithSpouse <> YES)	no		
     #This question is for ABD person who is either not married or married but not living with spouse. It uses the individual resource limit.  So it can be asked of 300% SSI individuals who are in an institution if they are getting Medicaid and married, but not if they are applying.  It also covers CaidGet and CaidApply for all other groups but 80% FPL, QMB, SLMB, QI, QDWI.  Plus it covers CaidApply for WORKS.  It does not cover institutional or waiver services for those in other covered groups.  The value of the non-home
     #contiguous property over $5,000 is a countable resource, unless it can be excluded for another reason listed in subchapter S1130.	86.00	See M0530.200 -- A married individual living with his/her spouse is always an ABD couple assistance unit (2 persons) for the resource eligibility determination.  If user is in an institution (or has a Waiver -- the exception to the 2 person rule) then user is assistance unit of one.  The general $2000 limit is used for individual in institution.  A separate question is asked for user applying for instition if married to community spouse.  
 
       @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidMostGroupsResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidMostGroupsResourceLimitExceed']) 

       if @CaidMostGroupsResourceLimitExceed.blank? then
          @CaidMostGroupsResourceLimitExceed = Question.new(:name => 'CaidMostGroupsResourceLimitExceed', :text => 'CaidMostGroupsResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '81.00',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
       end

       @CaidMostGroupsResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ Medicaid resource limit? (Include your share of any equity in real estate contiguous to your home over the ~ limit and your share of any other real property)") 
       @CaidMostGroupsResourceLimitExceed.update_attribute(:default_answer, "No")
       @CaidMostGroupsResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
       @CaidMostGroupsResourceLimitExceed.update_attribute(:question_type, "select") 
       @CaidMostGroupsResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
       @CaidMostGroupsResourceLimitExceed.update_attribute(:question_order, "3")
       @CaidMostGroupsResourceLimitExceed.update_attribute(:workbook_order, "86") 

        # If ((((CaidGet = YES 
              #AND VA_CaidGetCoveredGroup = (SSI Recipient OR 1619b (SSI Medicaid while working) OR Auxiliary Grant OR Adult Disabled Child OR Protected SSI Disabled Child 
              #OR 300% SSI OR Medically Needy(Spendown)))  
              #OR (CaidApply = YES AND VA_CaidApplyCoveredGroup =  (SSI Recipient OR 1619b (SSI Medicaid while working) OR MEDICAID WORKS OR Auxiliary Grant 
              #OR Adult Disabled Child OR Protected SSI Disabled Child OR Medically Needy(Spendown)))) AND LiveWithSpouse <> YES)
        
   @CaidMostGroupsResourceLimitExceed.update_attribute(:display_rules, "
     CaidGet = manager.get_answer_by_question_name('CaidGet')
     VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
     CaidApply = manager.get_answer_by_question_name('CaidApply')
     VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
     (( CaidGet == 'Yes' && 
      (VA_CaidGetCoveredGroup == 'SSI Recipient' || VA_CaidGetCoveredGroup == '1619b (SSI Medicaid while working)' || VA_CaidGetCoveredGroup == 'Auxiliary Grant' ||
       VA_CaidGetCoveredGroup == 'Adult Disabled Child' || VA_CaidGetCoveredGroup == 'Protected SSI Disabled Child'  || 
       VA_CaidGetCoveredGroup == '300% SSI' || VA_CaidGetCoveredGroup == 'Medically Needy(Spendown)' )) ||
      ( CaidApply == 'Yes' && 
       (VA_CaidApplyCoveredGroup == 'SSI Recipient' || VA_CaidApplyCoveredGroup == '1619b (SSI Medicaid while working)' || VA_CaidApplyCoveredGroup == 'MEDICAID WORKS' ||
        VA_CaidApplyCoveredGroup == 'Auxiliary Grant' || 
        VA_CaidApplyCoveredGroup == 'Adult Disabled Child' || VA_CaidApplyCoveredGroup == 'Protected SSI Disabled Child'  || 
        VA_CaidApplyCoveredGroup == 'Medically Needy(Spendown)')) && LiveWithSpouse != 'Yes') ")


  #     #This is not the best way to add a new calc but i forgot this calc does not exist yet
  #       @RateCaidMostGroupsResourceLimit = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')
  #       if @RateCaidMostGroupsResourceLimit.blank? then
  #         @RateCaidMostGroupsResourceLimit  = WebCalc.new(:name => 'RateCaidMostGroupsResourceLimit')
  #       end
  #
  #        @RateCaidMostGroupsResourceLimit.operation = "
  #        unless manager.get_answer_by_question_name('SitDate').blank? 
  #       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #               rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  #              RateCaidMostGroupsResourceLimit = rate.RateCaidMostGroupsResourceLimit
  #          else
  #             RateCaidMostGroupsResourceLimit =  2000
  #          end
  #         "
  #         @RateCaidMostGroupsResourceLimit.save!

         # calc to insert
         @RateCaidMostGroupsResourceLimit  = WebCalc.find_by_name('RateCaidMostGroupsResourceLimit')

         unless @RateCaidMostGroupsResourceLimit.blank?

            @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidMostGroupsResourceLimitExceed.id, 1])
            if @Insert1.blank? then
               @Insert1  = QuestionInsert.new(:question_id => @CaidMostGroupsResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCaidMostGroupsResourceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
               @Insert1.save!
           else
             @Insert1.update_attribute(:question_id, @CaidMostGroupsResourceLimitExceed.id) 
             @Insert1.update_attribute(:insert_number, '1')
             @Insert1.update_attribute(:webcalc_id_to_insert, @RateCaidMostGroupsResourceLimit.id) 
             @Insert1.update_attribute(:insert_marker, '~')
             @Insert1.update_attribute(:insert_type, 'currency')
            end
         end
         
         #2nd calc to insert
        @VA_RateCaidRealEstateResourceLimit  = WebCalc.find_by_name('VA_RateCaidRealEstateResourceLimit')
        unless @VA_RateCaidRealEstateResourceLimit.blank?

          @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidMostGroupsResourceLimitExceed.id, 2])
          if @Insert2.blank? then
             @Insert2  = QuestionInsert.new(:question_id => @CaidMostGroupsResourceLimitExceed.id, :insert_number => '2', :webcalc_id_to_insert => @VA_RateCaidRealEstateResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
             @Insert2.save!
         else
           @Insert2.update_attribute(:question_id, @CaidMostGroupsResourceLimitExceed.id) 
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
