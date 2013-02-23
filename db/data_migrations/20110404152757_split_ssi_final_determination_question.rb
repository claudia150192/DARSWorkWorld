class SplitSsiFinalDeterminationQuestion < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
  #BAH Looking back i bet without the save this didn't take  
   @questionSsiGetFinalDetermination = Question.find_by_name('SsiGetFinalDetermination')
   @questionSsiGetFinalDetermination.update_attribute(:text, 'Do you have a Final Determination letter from SSA saying that you are eligible for SSI?') unless @questionSsiGetFinalDetermination.blank?
   
  @SsiGet12MonthsSinceOnset = Question.create!(:name => 'SsiGet12MonthsSinceOnset',
  :group_id => '63858',
  :workbook_order => '28.5',
  :question_order => '3',
  :text => 'Has it been at least 12 months since the onset of your disability as determined by SSA for SSI eligibility purposes?', 
  :display_rules => "SsiGet = manager.get_answer_by_question_name('SsiGet')
  Blind = manager.get_answer_by_question_name('Blind')
  SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
  SsiGet == 'Yes' && Blind == 'No' && SsiGetFinalDetermination == 'Yes'", 
  :default_answer => 'No',          :reference_id =>   '30.5',   :question_type => 'select',       :answer_choices => 'Yes, No')
      
    @questionSsiGetFinalDetermination.update_attribute(:reference_id, '30') unless @questionSsiGetFinalDetermination.blank?
    
  end

  def self.down
  end
end
