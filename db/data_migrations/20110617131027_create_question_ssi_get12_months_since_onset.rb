class CreateQuestionSsiGet12MonthsSinceOnset < ActiveRecord::Migration
  def self.up
    
    #36 37	30.5	Has it been at least 12 months since the onset of your disability as determined by SSA for SSI eligibility purposes?	SsiGet12MonthsSinceOnset			YES:NO		NO	If SsiGetFinalDetermination = YES AND Blind = NO	no			28.50
    #ssi group "SSI"
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSI'])
    @SsiGet12MonthsSinceOnset = Question.find(:first, :conditions => ['name = ?',  'SsiGet12MonthsSinceOnset']) 

   if @SsiGet12MonthsSinceOnset.blank? then
      @SsiGet12MonthsSinceOnset = Question.new(:name => 'SsiGet12MonthsSinceOnset', :text => 'SsiGet12MonthsSinceOnset?', :display_rules => 'always', :default_answer => 'No', :reference_id => '30.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
   end
  
   @SsiGet12MonthsSinceOnset.update_attribute(:text, "Has it been at least 12 months since the onset of your disability as determined by SSA for SSI eligibility purposes?") 
   @SsiGet12MonthsSinceOnset.update_attribute(:default_answer, "No")
   @SsiGet12MonthsSinceOnset.update_attribute(:group_id, @QuestionGroup.id) 
   @SsiGet12MonthsSinceOnset.update_attribute(:question_type, "select") 
   @SsiGet12MonthsSinceOnset.update_attribute(:answer_choices, "Yes, No") 
   @SsiGet12MonthsSinceOnset.update_attribute(:question_order, "3")
   @SsiGet12MonthsSinceOnset.update_attribute(:workbook_order, "28.5") 

    # If SsiGetFinalDetermination = YES AND Blind = NO
   @SsiGet12MonthsSinceOnset.update_attribute(:display_rules, "
    SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
    Blind = manager.get_answer_by_question_name('Blind')
    (SsiGetFinalDetermination == 'Yes' && Blind == 'No')")
  end

  def self.down
  end
end
