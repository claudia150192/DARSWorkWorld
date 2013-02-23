class UpdateQuestionCaidGetWorksResourceLimitExceedRenameDisplayRuleAndInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
    
    #This is not the best way to add a new calc but i forgot this calc does not exist yet
     @VA_RateCaidWorksResourceLimit = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')
     if @VA_RateCaidWorksResourceLimit.blank? then
       @VA_RateCaidWorksResourceLimit  = WebCalc.new(:name => 'VA_RateCaidWorksResourceLimit')
     end

      @VA_RateCaidWorksResourceLimit.operation = "
      unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
             rate = VaMedicaidRate.find(:last, :conditions => ['start_date <= ?', SitDate])
            VA_RateCaidWorksResourceLimit = rate.va_rate_caid_works_resource_limit
        else
           VA_RateCaidWorksResourceLimit =  32545
        end
       "
       @VA_RateCaidWorksResourceLimit.save!
        
     # old name CaidWorksResourceLimitExceed
     #new name CaidGetWorksResourceLimitExceed
     
     #Do you have countable resources that exceed the <VA_RateCaidWorksResourceLimit> resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)
          
    #question edit to add insert marker
    @CaidGetWorksResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidWorksResourceLimitExceed']) 
    
    if @CaidGetWorksResourceLimitExceed.blank? then
      @CaidGetWorksResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidGetWorksResourceLimitExceed']) 
    end
    
    @CaidGetWorksResourceLimitExceed.update_attribute(:text, "Do you have countable resources that exceed the ~ resource limit for MEDICAID WORKS? (Do NOT include deemed resources.)") 
   
   @CaidGetWorksResourceLimitExceed.update_attribute(:name, "CaidGetWorksResourceLimitExceed") 
 
  # If ((CaidGet = Y AND VA_CaidGetCoveredGroup = MEDICAID WORKS)
     @CaidGetWorksResourceLimitExceed.update_attribute(:display_rules, "
   CaidGet = manager.get_answer_by_question_name('CaidGet')
   VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
   (CaidGet == 'Yes' && VA_CaidGetCoveredGroup == 'MEDICAID WORKS')") 

   # calc to insert
   @VA_RateCaidWorksResourceLimit  = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')

   @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidGetWorksResourceLimitExceed.id, 1])
   if @Insert2.blank? then
      @Insert2  = QuestionInsert.new(:question_id => @CaidGetWorksResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @VA_RateCaidWorksResourceLimit.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:question_id, @CaidGetWorksResourceLimitExceed.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @VA_RateCaidWorksResourceLimit.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
