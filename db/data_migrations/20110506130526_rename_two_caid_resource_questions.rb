class RenameTwoCaidResourceQuestions < ActiveRecord::Migration
  def self.up
    @question1 = Question.find_by_name('CaidResourceLimitExceed')
    @question1.update_attribute(:name, 'CaidMostGroupsResourceLimitExceed') unless @question1.blank?
    
    #If ((CaidGet = Y AND VA_CaidGetCoveredGroup <> (QDWI OR QMB OR SLMB OR QI OR MEDICAID WORKS))  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup <>  (QDWI OR QMB OR SLMB OR QI))) AND LiveWithSpouse = N
    @question1.update_attribute(:display_rules, "
    CaidGet = manager.get_answer_by_question_name('CaidGet')
    VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
    CaidApply = manager.get_answer_by_question_name('CaidApply')
    VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
    LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
    ((( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup != 'QDWI' && VA_CaidGetCoveredGroup != 'QDWI' && VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'MEDICAID WORKS'))   
    || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup != 'QDWI' && VA_CaidApplyCoveredGroup != 'QDWI' && VA_CaidApplyCoveredGroup != 'QMB' && VA_CaidApplyCoveredGroup != 'SLMB' && VA_CaidApplyCoveredGroup != 'QI')))  && LiveWithSpouse == 'No' 
    ") unless @question1.blank? 
  
  
     @question2 = Question.find_by_name('CaidCoupleResourceLimitExceed')
      @question2.update_attribute(:name, 'CaidCoupleMostGroupsResourceLimitExceed') unless @question2.blank?
  # If ((CaidGet = Y AND VA_CaidGetCoveredGroup <> (QDWI OR QMB OR SLMB OR QI OR MEDICAID WORKS))  
  #OR (CaidApply = Y AND VA_CaidApplyCoveredGroup <>  (QDWI OR QMB OR SLMB OR QI)) 
  #OR (CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup <> (QDWI OR QMB OR SLMB OR QI OR MEDICAID WORKS))  
  #OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup <>  (QDWI OR QMB OR SLMB OR QI))) AND LiveWithSpouse =Y
   @question2.update_attribute(:display_rules, "
    CaidGet = manager.get_answer_by_question_name('CaidGet')
    VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
    CaidApply = manager.get_answer_by_question_name('CaidApply')
    VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
    LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
    VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
    VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
    ((( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup != 'QDWI' && VA_CaidGetCoveredGroup != 'QMB' && VA_CaidGetCoveredGroup != 'SLMB' && VA_CaidGetCoveredGroup != 'QI' && VA_CaidGetCoveredGroup != 'MEDICAID WORKS'))   
    || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup != 'QDWI' && VA_CaidApplyCoveredGroup != 'QMB' && VA_CaidApplyCoveredGroup != 'SLMB' && VA_CaidApplyCoveredGroup != 'QI'))
    || ( CaidSpouseGet == 'Yes' && (VA_CaidSpouseGetCoveredGroup != 'QDWI' && VA_CaidSpouseGetCoveredGroup != 'QMB' && VA_CaidSpouseGetCoveredGroup != 'SLMB' && VA_CaidSpouseGetCoveredGroup != 'QI' && VA_CaidSpouseGetCoveredGroup != 'MEDICAID WORKS'))
    || ( CaidSpouseApply == 'Yes' && (VA_CaidSpouseApplyCoveredGroup != 'QDWI' && VA_CaidSpouseApplyCoveredGroup != 'QMB' && VA_CaidSpouseApplyCoveredGroup != 'SLMB' && VA_CaidSpouseApplyCoveredGroup != 'QI')))  
    && LiveWithSpouse == 'Yes' 
    ") unless @question2.blank? 
  
  end

  def self.down
  end
end
