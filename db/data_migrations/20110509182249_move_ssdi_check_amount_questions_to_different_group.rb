class MoveSsdiCheckAmountQuestionsToDifferentGroup < ActiveRecord::Migration
  def self.up
   
   
    require 'wwweb_session_manager'   
    @SsdiQuestionsGroup = QuestionGroup.find_by_name('SSDI')
    @Spouse_SsdiQuestionsGroup = QuestionGroup.find_by_name('Spouse SSDI')
    
     
    @SsdiActualAmt         = Question.find_by_name('SsdiActualAmt')
    @SpouseSsdiActualAmt   = Question.find_by_name('SpouseSsdiActualAmt')

    #@question = Question.find_by_name('BirthDate')
    #@question.update_attribute(:validation_message, 'Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 01/22/1990 for January 22nd, 1990.') unless @question.blank?


    @SsdiActualAmt.update_attribute(:default_answer, '0.00') unless @SsdiActualAmt.blank?
    @SsdiActualAmt.update_attribute(:group_id, @SsdiQuestionsGroup.id) unless (@SsdiQuestionsGroup.blank? || @SsdiActualAmt.blank?)
    @SsdiActualAmt.update_attribute(:question_order, '9') unless @SsdiActualAmt.blank?
    #If Current/What-If Button = Current AND SsdiGet = Y  Display rule for SsdiActualAmt did not change
    
    @SpouseSsdiActualAmt.update_attribute(:group_id, @Spouse_SsdiQuestionsGroup.id) unless @SpouseSsdiActualAmt.blank?    
    @SpouseSsdiActualAmt.update_attribute(:default_answer, '0.00') unless @SpouseSsdiActualAmt.blank?    
    @SpouseSsdiActualAmt.update_attribute(:question_order, '8') unless @SpouseSsdiActualAmt.blank?    
    #DIsplay rule also unchanged.

#@CaidQdwiResourceLimitExceed   =  Question.create!(:name => 'CaidQdwiResourceLimitExceed', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '5')

  end

  def self.down
  end
end
