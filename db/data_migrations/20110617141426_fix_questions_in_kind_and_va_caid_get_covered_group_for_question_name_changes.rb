class FixQuestionsInKindAndVaCaidGetCoveredGroupForQuestionNameChanges < ActiveRecord::Migration
  def self.up
    
    #WOrkbook
    #30	84	In-Kind Support: Is your SSI check reduced because of In-Kind Support from others in your household?	InKind			YES:NO		YES	If SsiGet = Y AND SsiResourceLimitExceed <> Y AND SsiCoupleResourceLimitExceed <> Y AND (LiveWithSpouseAndOthers = Y OR LiveWithOthers = Y OR (LiveWithParents =  Y AND RAge > 17)) AND VA_LiveWithSpouseAuxGrantFacility <> Y AND LiveWithSpouseInFacility <> Y AND VA_LiveInAuxGrantFacility <> Y AND LiveInFacility <> Y	no	NO	Note that the question appears for user who lives with parents because we ask that if user is under age 22, but parental deeming stops at age 18, so parent's income may be in-kind support.	89.00
    
    #web
    #InKind 	Is your SSI check reduced because of In-Kind Support from others in your household 	SsiGet = manager.get_answer_by_question_name('SsiGet') SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed ') SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed') LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers') LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers') LiveWithParents = manager.get_answer_by_question_name('LiveWithParents') RAge = WebCalc.find_by_name('RAge') Age = Float(RAge.calculate manager) VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility') VA_CaidLiveWithSpouseInFacility = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseInFacility') VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility') VA_CaidLiveInFacility = manager.get_answer_by_question_name('VA_CaidLiveInFacility') (SsiGet == 'Yes') && (SsiResourceLimitExceed != 'Yes') && (SsiCoupleResourceLimitExceed != 'Yes') && ((LiveWithSpouseAndOthers == 'Yes' || LiveWithOthers == 'Yes') || (LiveWithParents == 'Yes' && RAge > 17)) && (VA_LiveWithSpouseAuxGrantFacility != 'Yes') && (VA_CaidLiveWithSpouseInFacility != 'Yes') && (VA_LiveInAuxGrantFacility != 'Yes') && (VA_CaidLiveInFacility != 'Yes') 	84 	In-Kind Support 	select 	Yes, No 	No 	1 				89.0
    
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'In-Kind Support'])
    @InKind = Question.find(:first, :conditions => ['name = ?',  'InKind']) 

   if @InKind.blank? then
      @InKind = Question.new(:name => 'InKind', :text => 'InKind?', :display_rules => 'always', :default_answer => 'Yes', :reference_id => '84',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 1 , :group_id => @QuestionGroup.id) 
   end

   @InKind.update_attribute(:text, "In-Kind Support: Is your SSI check reduced because of In-Kind Support from others in your household?") 
   @InKind.update_attribute(:default_answer, "Yes")
   @InKind.update_attribute(:group_id, @QuestionGroup.id) 
   @InKind.update_attribute(:question_type, "select") 
   @InKind.update_attribute(:answer_choices, "Yes, No") 
   @InKind.update_attribute(:question_order, "1")
   @InKind.update_attribute(:workbook_order, "89") 


    # If SsiGet = Y AND SsiResourceLimitExceed <> Y AND SsiCoupleResourceLimitExceed <> Y AND (LiveWithSpouseAndOthers = Y OR LiveWithOthers = Y OR (LiveWithParents =  Y AND RAge > 17)) AND VA_LiveWithSpouseAuxGrantFacility <> Y AND LiveWithSpouseInFacility <> Y AND VA_LiveInAuxGrantFacility <> Y AND LiveInFacility <> Y
    
  @InKind.update_attribute(:display_rules, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    SsiResourceLimitExceed  = manager.get_answer_by_question_name('SsiResourceLimitExceed')
    SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
    LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
    LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
    LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
    RAge = WebCalc.find_by_name('RAge')
    Age = Float(RAge.calculate manager)
    VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
    LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
    VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
    LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
    (SsiGet == 'Yes') && (SsiResourceLimitExceed != 'Yes') && (SsiCoupleResourceLimitExceed != 'Yes') && ((LiveWithSpouseAndOthers == 'Yes' || LiveWithOthers == 'Yes') || (LiveWithParents ==  'Yes' && RAge > 17)) && (VA_LiveWithSpouseAuxGrantFacility != 'Yes') && (LiveWithSpouseInFacility != 'Yes') && (VA_LiveInAuxGrantFacility != 'Yes') && (LiveInFacility != 'Yes')
    ")
   
   #25 45	33	Virginia Medicaid: Under what Covered Group do you have Medicaid Coverage?	VA_CaidGetCoveredGroup			SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:Waiver:Medical Institution:Medically Needy(Spendown):Other		EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (LiveWithSpouseInFacility = Y OR LiveInFacility = Y), THEN Medical Institution, ELSE 80% FPL	If State = Virginia AND CaidGet = Y	Appear	QMB	If we add other states, they will have different covered groups.  I've added Jack Q's suggested wording on 1619b, removed Protected SSI Child.	31.00
    
     @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
      @VA_CaidGetCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidGetCoveredGroup']) 

     if @VA_CaidGetCoveredGroup.blank? then
        @VA_CaidGetCoveredGroup = Question.new(:name => 'VA_CaidGetCoveredGroup', :text => 'VA_CaidGetCoveredGroup?', :display_rules => 'always', :default_answer => '80% FPL', :reference_id => '33',  :question_type => 'select', :answer_choices => 'SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown), Other', :question_order => 2 , :group_id => @QuestionGroup.id) 
     end

     @VA_CaidGetCoveredGroup.update_attribute(:text, "Virginia Medicaid: Under what Covered Group do you have Medicaid Coverage?") 
     #@VA_CaidGetCoveredGroup.update_attribute(:default_answer, "Yes")
     @VA_CaidGetCoveredGroup.update_attribute(:group_id, @QuestionGroup.id) 
     @VA_CaidGetCoveredGroup.update_attribute(:question_type, "select") 
     @VA_CaidGetCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown), Other") 
     @VA_CaidGetCoveredGroup.update_attribute(:question_order, "2")
     @VA_CaidGetCoveredGroup.update_attribute(:workbook_order, "31") 

      # If State = Virginia AND CaidGet = Y
      @VA_CaidGetCoveredGroup.update_attribute(:display_rules, "
      State = manager.get_answer_by_question_name('State')
      CaidGet  = manager.get_answer_by_question_name('CaidGet')
      (State == 'Virginia' && CaidGet == 'Yes')
      ")   
      
      #EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (LiveWithSpouseInFacility = Y OR LiveInFacility = Y), THEN Medical Institution, ELSE 80% FPL
      @VA_CaidGetCoveredGroup.update_attribute(:default_answer, "expression= 
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
      LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
      if SsiGet == 'Yes' then
        answer = 'SSI Recipient'
      elsif (LiveWithSpouseInFacility == 'Yes' || LiveInFacility == 'Yes') then
        answer = 'Medical Institution'
      else 
        answer = '80% FPL'
      end
      ")
      
      
      #THis was not changed by question name change, did it mostly for text and answer choices.  May need to be redone if Ruth edits
      #25	35	Under what Virginia Covered Group are you applying for Medicaid coverage?	VA_CaidApplyCoveredGroup			SSI Recipient:1619b (SSI Medicaid while working):MEDICAID WORKS:Auxiliary Grant:  Adult Disabled Child: Protected SSI Disabled Child: QMB: SLMB: QI: QDWI: 80% FPL: Waiver: Medical Institution: Medically Needy(Spendown)		80% FPL	IF State = Virginia AND CaidApply = Y	no			33.00
         @VA_CaidApplyCoveredGroup = Question.find(:first, :conditions => ['name = ?',  'VA_CaidApplyCoveredGroup']) 
        
                                                    #web answer choices                                               SSI Recipient, 1619b,                            MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown)
        if @VA_CaidApplyCoveredGroup.blank? then
            @VA_CaidApplyCoveredGroup = Question.new(:name => 'VA_CaidApplyCoveredGroup', :text => 'VA_CaidApplyCoveredGroup?', :display_rules => 'always', :default_answer => '80% FPL', :reference_id => '35',  :question_type => 'select', :answer_choices => 'SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown), Other', :question_order => 4 , :group_id => @QuestionGroup.id) 
         end

         @VA_CaidApplyCoveredGroup.update_attribute(:text, "Virginia Medicaid: Under what Virginia Covered Group are you applying for Medicaid coverage?") 
         @VA_CaidApplyCoveredGroup.update_attribute(:default_answer, "80% FPL")
         @VA_CaidApplyCoveredGroup.update_attribute(:group_id, @QuestionGroup.id) 
         @VA_CaidApplyCoveredGroup.update_attribute(:question_type, "select") 
         @VA_CaidApplyCoveredGroup.update_attribute(:answer_choices, "SSI Recipient, 1619b (SSI Medicaid while working), MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown)") 
         @VA_CaidApplyCoveredGroup.update_attribute(:question_order, "4")
         @VA_CaidApplyCoveredGroup.update_attribute(:workbook_order, "33") 

          # IF State = Virginia AND CaidApply = Y
          @VA_CaidApplyCoveredGroup.update_attribute(:display_rules, "
          State = manager.get_answer_by_question_name('State')
          CaidApply  = manager.get_answer_by_question_name('CaidApply')
          (State == 'Virginia' && CaidApply == 'Yes')
          ")  

 #       #EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (LiveWithSpouseInFacility = Y OR LiveInFacility = Y), THEN Medical Institution, ELSE 80% FPL
 #       @VA_CaidGetCoveredGroup.update_attribute(:default_answer, "expression= 
 #       SsiGet = manager.get_answer_by_question_name('SsiGet')
 #       LiveWithSpouseInFacility = manager.get_answer_by_question_name('LiveWithSpouseInFacility')
 #       LiveInFacility = manager.get_answer_by_question_name('LiveInFacility')
 #       if SsiGet == 'Yes' then
 #         answer = 'SSI Recipient'
 #       elsif (LiveWithSpouseInFacility == 'Yes' || LiveInFacility == 'Yes') then
 #         answer = 'Medical Institution'
 #       else 
 #         answer = '80% FPL'
 #       end
 #       ")
      
  end

  def self.down
  end
end
