class RecreateQuestionCaidSpouseCoupleQdwiResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
      #45 47 48	82.6	Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~RateCoupleQwdiResouceLimit~  QDWI Medicaid resource limit? (Include any deemed resources.)	
      #CaidSpouseCoupleQdwiResourceLimitExceed			YES:NO		NO	IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = QDWI)  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = QDWI))	no				87.65
      
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
        @CaidSpouseCoupleQdwiResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'CaidSpouseCoupleQdwiResourceLimitExceed']) 


        if @CaidSpouseCoupleQdwiResourceLimitExceed.blank? then
           @CaidSpouseCoupleQdwiResourceLimitExceed = Question.new(:name => 'CaidSpouseCoupleQdwiResourceLimitExceed', :text => 'CaidSpouseCoupleQdwiResourceLimitExceed?', :display_rules => 'always', :default_answer => 'No', :reference_id => '82.6',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 18, :group_id => @QuestionGroup.id) 
        end

        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:text, "Spouse Resource Eligibility:  Do you and your spouse have countable resources that exceed the ~ QDWI Medicaid resource limit? (Include any deemed resources.)") 
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:default_answer, "No")
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:group_id, @QuestionGroup.id) 
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:question_type, "select") 
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:answer_choices, "Yes, No") 
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:question_order, "18")
        @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.65") 

       #   IF R_VA_CaidUserSpouseSameCovGroup = FALSE AND ((CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = QDWI)  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = QDWI))
              
       @CaidSpouseCoupleQdwiResourceLimitExceed.update_attribute(:display_rules, "
        R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
        R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
         CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
         VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
         VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
         LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
         CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
         (R_VA_CaidUserSpouseSameCovGroup == false && ((CaidSpouseGet == 'Yes'  &&  (VA_CaidSpouseGetCoveredGroup == 'QDWI'))  || 
          (CaidSpouseApply == 'Yes'  && (VA_CaidSpouseGetCoveredGroup == 'QDWI'))))")
       
   
        # calc to insert
           @RateCoupleQwdiResouceLimit  = WebCalc.find_by_name('RateCoupleQwdiResouceLimit')

        unless @RateCoupleQwdiResouceLimit.blank?

           @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CaidSpouseCoupleQdwiResourceLimitExceed.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionInsert.new(:question_id => @CaidSpouseCoupleQdwiResourceLimitExceed.id, :insert_number => '1', :webcalc_id_to_insert => @RateCoupleQwdiResouceLimit.id, :insert_marker => "~", :insert_type => 'currency') 
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @CaidSpouseCoupleQdwiResourceLimitExceed.id) 
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RateCoupleQwdiResouceLimit.id) 
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end
         end
  end

  def self.down
  end
end
