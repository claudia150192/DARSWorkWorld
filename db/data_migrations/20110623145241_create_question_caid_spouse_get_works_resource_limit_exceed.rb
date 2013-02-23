class CreateQuestionCaidSpouseGetWorksResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager' 

      #45	82.75	Does your spouse have countable resources that exceed the <VA_RateCaidWorksResourceLimit> resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)	
      # CaidSpouseGetWorksResourceLimitExceed			YES:NO		NO	IF CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = MEDICAID WORKS	no		This one does not need the "different" Medicaid group criteria because spouse is treated as individual even if both user and spouse have MEDICAID WORKS.	87.80
       

         @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
          @CaidSpouseGetWorksResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseGetWorksResourceLimitExceed']) 

         if @CaidSpouseGetWorksResourceLimitExceed.blank? then
            @CaidSpouseGetWorksResourceLimitExceed = Question.new(:name => 'CaidSpouseGetWorksResourceLimitExceed', :text => 'CaidSpouseGetWorksResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.75',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 15 , :group_id => @QuestionGroup.id) 
         end

         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:text, "Does your spouse have countable resources that exceed the ~ resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)") 
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:default_answer, "No")
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:question_type, "select") 
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:question_order, "15")
         @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:workbook_order, "87.80") 


         #IF CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = MEDICAID WORKS
        @CaidSpouseGetWorksResourceLimitExceed.update_attribute(:display_rules, "
         CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
        VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
        (CaidSpouseGet == 'Yes' && VA_CaidSpouseGetCoveredGroup == 'MEDICAID WORKS')")

        #this should be found
          @VA_RateCaidWorksResourceLimit = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')

 #     #this has been added so should not execute I'm a bit leery changing this often used calc here
 #       if @VA_RateCaidWorksResourceLimit.blank? then
 #         @VA_RateCaidWorksResourceLimit  = WebCalc.new(:name => 'VA_RateCaidWorksResourceLimit')
 #       end
 #
 #      @VA_RateCaidWorksResourceLimit.operation = "
 #       unless manager.get_answer_by_question_name('SitDate').blank? 
 #      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 #              rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
 #             VA_RateCaidWorksResourceLimit = rate.VA_RateCaidWorksResourceLimit
 #         else
 #            VA_RateCaidWorksResourceLimit =  6000
 #         end
 #      "
 #         @VA_RateCaidWorksResourceLimit.save!

        # calc to insert
        @VA_RateCaidWorksResourceLimit  = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')

        @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseGetWorksResourceLimitExceed.id, 1])
        if @Insert2.blank? then
           @Insert2  = QuestionInsert.new(:question_id => @CaidSpouseGetWorksResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @VA_RateCaidWorksResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert2.save!
       else
         @Insert2.update_attribute(:question_id, @CaidSpouseGetWorksResourceLimitExceed.id)
         @Insert2.update_attribute(:insert_number, '1')
         @Insert2.update_attribute(:webcalc_id_to_insert, @VA_RateCaidWorksResourceLimit.id)
         @Insert2.update_attribute(:insert_marker, '~')
         @Insert2.update_attribute(:insert_type, 'currency')
        end
  end

  def self.down
  end
end
