class Modify5NewResourceQuestionsWithTextAndDisplayRules < ActiveRecord::Migration
  def self.up
    #based on workbook 41
    require 'wwweb_session_manager'    
           
      @CaidQdwiResourceLimitExceed            =  Question.find_by_name('CaidQdwiResourceLimitExceed')
      @CaidCoupleQdwiResourceLimitExceed      =  Question.find_by_name('CaidCoupleQdwiResourceLimitExceed')
      @CaidQmbSlmbQiResourceLimitExceed       =  Question.find_by_name('CaidQmbSlmbQiResourceLimitExceed')
      @CaidCoupleQmbSlmbQiResourceLimitExceed =  Question.find_by_name('CaidCoupleQmbSlmbQiResourceLimitExceed')
      @CaidWorksResourceLimitExceed           =  Question.find_by_name('CaidWorksResourceLimitExceed')
     
     @CaidQdwiResourceLimitExceed.update_attribute(:text, 'Do you have countable resources that exceed the QDWI Medicaid resource limit? (Include any deemed resources.)') unless @CaidQdwiResourceLimitExceed.blank?  
     @CaidCoupleQdwiResourceLimitExceed.update_attribute(:text, 'Do you and your spouse have countable resources that exceed the QWDI Medicaid resource limit for couples? (Include any deemed resources.)') unless @CaidCoupleQdwiResourceLimitExceed.blank?  
     @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:text, 'Do you have countable resources that exceed the resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.') unless @CaidQmbSlmbQiResourceLimitExceed.blank?   
     @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:text, 'Do you and your spouse have countable resources that exceed the couples resource limit for QMB, SLMB or QI Medicaid? (Include any deemed resources.') unless @CaidCoupleQmbSlmbQiResourceLimitExceed.blank?  
     @CaidWorksResourceLimitExceed.update_attribute(:text, 'Do you have countable resources that exceed the resource limit for MEDICAID WORKS? (Do NOT include deemed resources.') unless @CaidWorksResourceLimitExceed.blank?  
     
     
     #If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup =  QDWI)) AND LiveWithSpouse = N
     @CaidQdwiResourceLimitExceed.update_attribute(:display_rules, "
     CaidGet = manager.get_answer_by_question_name('CaidGet')
     VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
     CaidApply = manager.get_answer_by_question_name('CaidApply')
     VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse') 
     (( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QDWI') || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QDWI'))  && LiveWithSpouse == 'No' 
     ") unless @CaidQdwiResourceLimitExceed.blank?
   
   
   #  If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = QDWI) OR (CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = QDWI)  OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = QDWI)) AND LiveWithSpouse =Y
        @CaidCoupleQdwiResourceLimitExceed.update_attribute(:display_rules, "
     CaidGet = manager.get_answer_by_question_name('CaidGet')
     VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
     CaidApply = manager.get_answer_by_question_name('CaidApply')
     VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')   
     CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
     VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
     CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
     VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
     (( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QDWI') || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QDWI')
      || ( CaidSpouseGet == 'Yes' && (VA_CaidSpouseGetCoveredGroup == 'QDWI')
      || ( CaidSpouseApply == 'Yes' && (VA_CaidSpouseApplyCoveredGroup == 'QDWI')      
      )  && LiveWithSpouse == 'Yes'   
     ") unless @CaidCoupleQdwiResourceLimitExceed.blank?  
      
      
      #If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI)) OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR  SLMB OR QI))) AND LiveWithSpouse = N
      @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
      CaidGet = manager.get_answer_by_question_name('CaidGet')
       VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
       CaidApply = manager.get_answer_by_question_name('CaidApply')
       VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
       LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
       (( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QMB' || VA_CaidGetCoveredGroup == 'SLMB' || VA_CaidGetCoveredGroup == 'QI') || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QMB' || VA_CaidApplyCoveredGroup == 'SLMB' || VA_CaidApplyCoveredGroup == 'QI'))  && LiveWithSpouse == 'No'
      ") unless @CaidQmbSlmbQiResourceLimitExceed.blank?   
      
      #If ((CaidGet = Y AND VA_CaidGetCoveredGroup = (QMB OR SLMB OR = QI))  
       # OR (CaidApply = Y AND VA_CaidApplyCoveredGroup = (QMB OR SLMB OR = QI)) 
       # OR (CaidSpouseGet = Y AND VA_CaidSpouseGetCoveredGroup = (QMB OR SLMB OR = QI))  
       # OR (CaidSpouseApply = Y AND VA_CaidSpouseApplyCoveredGroup = (QMB OR SLMB OR = QI))) AND LiveWithSpouse =Y
      @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:display_rules, "
      CaidGet = manager.get_answer_by_question_name('CaidGet')
       VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
       CaidApply = manager.get_answer_by_question_name('CaidApply')
       VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')   
       CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
       VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
       CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
       VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
       LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
       (( CaidGet == 'Yes' && (VA_CaidGetCoveredGroup == 'QMB' || VA_CaidGetCoveredGroup == 'SLMB' || VA_CaidGetCoveredGroup == 'QI') || ( CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'QMB' || VA_CaidApplyCoveredGroup == 'SLMB' || VA_CaidApplyCoveredGroup == 'QI')
        || ( CaidSpouseGet == 'Yes' && (VA_CaidSpouseGetCoveredGroup == 'QMB' || VA_CaidSpouseGetCoveredGroup == 'SLMB' || VA_CaidSpouseGetCoveredGroup == 'QI')
        || ( CaidSpouseApply == 'Yes' && (VA_CaidSpouseApplyCoveredGroup == 'QMB' || VA_CaidSpouseApplyCoveredGroup == 'SLMB' || VA_CaidSpouseApplyCoveredGroup == 'QI')      
        )  && LiveWithSpouse == 'Yes'
      ") unless @CaidCoupleQmbSlmbQiResourceLimitExceed.blank?  
      
      
     # If ((CaidApply = Y AND VA_CaidApplyCoveredGroup = MEDICAID WORKS)
     @CaidWorksResourceLimitExceed.update_attribute(:display_rules, "
     CaidApply = manager.get_answer_by_question_name('CaidApply')
      VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
      CaidApply == 'Yes' && (VA_CaidApplyCoveredGroup == 'MEDICAID WORKS'
     ") unless @CaidWorksResourceLimitExceed.blank?  
   
     
  end

  def self.down
  end
end
