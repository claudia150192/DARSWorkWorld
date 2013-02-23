class MoveSsiCheckAmountQuestionsToDifferentGroupAndChangeWording < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'   
    
    #In WebQuest moved 181 (user actual SSI amount) up into SSI question group between 30.5 and 31.  Revised wording, appearance rules, and order number.  Question is asked of user even if married -- but now we ask just for the payment amount to user.  
    
    @SsiQuestionsGroup = QuestionGroup.find_by_name('SSI')
    @Spouse_SsiQuestionsGroup = QuestionGroup.find_by_name('Spouse SSI')
    
     
    @SsiUserActualAmt      = Question.find_by_name('SsiUserActualAmt')
    @SsiSpouseActualAmt   = Question.find_by_name('SsiCoupleActualAmt')

    @SsiUserActualAmt.update_attribute(:default_answer, '0.00') unless @SsiUserActualAmt.blank?
    @SsiUserActualAmt.update_attribute(:group_id, @SsiQuestionsGroup.id) unless (@SsiQuestionsGroup.blank? || @SsiUserActualAmt.blank?)
    @SsiUserActualAmt.update_attribute(:text, "What is the actual amount of your monthly SSI payment? (Do not count payment amounts to other family members, if any.)") unless @SsiUserActualAmt.blank?
    @SsiUserActualAmt.update_attribute(:question_order, '4') unless @SsiUserActualAmt.blank?
    #If Current/What-If Button = Current AND SsiGet = Y
    @SsiUserActualAmt.update_attribute(:display_rules, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    SsiGet == 'Yes'
    ") unless @SsiUserActualAmt.blank?
    
    #If Current/What-If Button = Current AND SsdiGet = Y  Display rule for SsdiActualAmt did not change
   #Forgot to mention he also changed the question name
    @SsiSpouseActualAmt.update_attribute(:name, 'SsiSpouseActualAmt') unless @SsiSpouseActualAmt.blank? 
    @SsiSpouseActualAmt.update_attribute(:group_id, @Spouse_SsiQuestionsGroup.id) unless @SsiSpouseActualAmt.blank?    
    @SsiSpouseActualAmt.update_attribute(:default_answer, '0.00') unless @SsiSpouseActualAmt.blank?    
    @SsiSpouseActualAmt.update_attribute(:text, "What is the actual monthly amount of the SSI payment that your spouse receives?") unless @SsiSpouseActualAmt.blank?
    @SsiSpouseActualAmt.update_attribute(:question_order, '2') unless @SsiSpouseActualAmt.blank?
    #If Current/What-If Button = Current AND SpouseSsiGet = Y
    @SsiSpouseActualAmt.update_attribute(:display_rules, "
    SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
    SpouseSsiGet == 'Yes'
    ") unless @SsiSpouseActualAmt.blank?
    
  end

  def self.down
  end
end
