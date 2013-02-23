class UpdateQuestionsDisplayRuleForMarriedLiveWithSpouseSplit < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager' 

    #25 29 45	14	What is your spouse's birthdate? (MM/DD/YYYY)	
    #SpouseBirthDate			MM/DD/YEAR or Calendar Popup	Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 01/21/1990 for January 21st, 1990. 	1/1/1950	IF Married = Y	Appear	5/26/1984	If spouse get's SSI, then the SEIE applies to the spouse's earnings.  It also applies to deemed income from spouse for SSI purposes.  (THIS IS NOT TRUE FOR 300% FBR MEDICAID. 	12.00
         
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
    @SpouseBirthDate = Question.find(:first, :conditions => ['name = ?',  'SpouseBirthDate']) 

       #IF Married = Y
      @SpouseBirthDate.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      Married == 'Yes'")
      
      
    #  25 45	15	Is your spouse legally blind according to SSA criteria?	SpouseBlind			YES:NO		NO	IF Married = Y	Appear	NO		13.00
     @SpouseBlind = Question.find(:first, :conditions => ['name = ?',  'SpouseBlind']) 

      #IF Married = Y
     @SpouseBlind.update_attribute(:display_rules, "
     Married = manager.get_answer_by_question_name('Married')
     Married == 'Yes'")


  #This is a new question and seems to be fine 
  #   45	21.4	          Does your spouse  live in an assisted living facility, a group home, an institution or foster care?	SpouseLiveInFacility			YES:NO		NO	IF Married = Y AND LiveWithSpouse = N	no			19.50
  #SpouseLiveInFacility 	Does your spouse live in an assisted living facility, a group home, an institution or foster care? 	Married = manager.get_answer_by_question_name('Married') LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse') (Married == 'Yes' && LiveWithSpouse == 'No') 	21.4 	Household Info 	select 	Yes, No 	No 	11 				19.5 
   
   
   #25 45	22	Do you live alone?	Alone			YES:NO		YES	IF Married = N OR LiveWithSpouse = N	no			20.00
   #Alone 	Do you live alone? 	LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse') LiveWithSpouse == 'No' 	22 	Household Info 	select 	Yes, No 	Yes 	12 				20.0
    @Alone = Question.find(:first, :conditions => ['name = ?',  'Alone']) 

     #IF Married = N OR LiveWithSpouse = N
    @Alone.update_attribute(:display_rules, "
    Married = manager.get_answer_by_question_name('Married')
    LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
    (Married == 'No' || LiveWithSpouse == 'No')")
   
  end

  def self.down
  end
end
