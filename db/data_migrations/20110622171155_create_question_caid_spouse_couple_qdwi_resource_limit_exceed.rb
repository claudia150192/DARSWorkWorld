class CreateQuestionCaidSpouseCoupleQdwiResourceLimitExceed < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager' 

     #45	82.6	Do you and your spouse have countable resources that exceed the <RateCoupleQwdiResouceLimit>  QWDI Medicaid resource limit? (Include any deemed resources.)
     #	CaidSpouseCoupleQdwiResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = Different AND ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = QDWI)  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = QDWI))	no			87.65
         
       @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleQdwiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleQdwiResourceLimitExceed']) 

       if @CaidSpouseCoupleQdwiResourceLimitExceed.blank? then
          @CaidSpouseCoupleQdwiResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleQdwiResourceLimitExceed', :text => 'CaidSpouseCoupleQdwiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.6',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 12 , :group_id => @QuestionGroup.id) 
       end

       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:text, "Do you and your spouse have countable resources that exceed the ~ QWDI Medicaid resource limit? (Include any deemed resources.)") 
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:default_answer, "No")
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:question_type, "select") 
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:question_order, "12")
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.65") 

      @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:display_rules, "
      R_VA_CaidUserSpouseSameCovGroup =  'this needs an edit, talked to DR on June 21'
      R_VA_CaidUserSpouseSameCovGroup == 'this needs an edit, talked to DR on June 21'")

      #this should be found
        @RateCoupleQwdiResouceLimit = WebCalc.find_by_name('RateCoupleQwdiResouceLimit')
      
      #this has been added so should not execute but just in case for completeness later on
        if @RateCoupleQwdiResouceLimit.blank? then
          @RateCoupleQwdiResouceLimit  = WebCalc.new(:name => 'RateCoupleQwdiResouceLimit')
        end
  
       @RateCoupleQwdiResouceLimit.operation = "
        unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
               rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
              RateCoupleQwdiResouceLimit = rate.RateCoupleQwdiResouceLimit
          else
             RateCoupleQwdiResouceLimit =  6000
          end
       "
          @RateCoupleQwdiResouceLimit.save!
  
      # calc to insert
      @RateCoupleQwdiResouceLimit  = WebCalc.find_by_name('RateCoupleQwdiResouceLimit')
  
      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleQdwiResourceLimitExceed.id, 1])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @CaidSpouseCoupleQdwiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQwdiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @CaidSpouseCoupleQdwiResourceLimitExceed.id)
       @Insert2.update_attribute(:insert_number, '1')
       @Insert2.update_attribute(:webcalc_id_to_insert, @RateCoupleQwdiResouceLimit.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
  end

  def self.down
  end
end
