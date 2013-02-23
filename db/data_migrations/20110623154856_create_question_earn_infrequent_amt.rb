class CreateQuestionEarnInfrequentAmt < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager' 

   #46	103.5	How much of the ~$SsiOrCaidEarnAmt~ you Receive is infrequent or irregular?	
   #EarnInfrequentAmt			Zero or Positive Number 	Enter positive numbers only.  Do not enter $.	0	If SsiOrCaidEarnAmt > 0	Appear	5.00	TIP NEEDED:  FOR VA MEDICAID PURPOSES, IF USER + SPOUSE'S INFREQ OR IRREG EARNED INCOME > $10, IT CANNOT BE EXCLUDED.   (See M0810.410)	108.50
   
     @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Own Earned Income'])
     @EarnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'EarnInfrequentAmt']) 
 
    if @EarnInfrequentAmt.blank? then
      @EarnInfrequentAmt = Question.new(:name => 'EarnInfrequentAmt', :text => 'EarnInfrequentAmt?', :display_rules => 'always', :default_answer => 'No', :reference_id => '103.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
    end
 
    @EarnInfrequentAmt.update_attribute(:text, "How much of the ~ you Receive is infrequent or irregular?") 
    @EarnInfrequentAmt.update_attribute(:default_answer, "No")
    @EarnInfrequentAmt.update_attribute(:group_id, @QuestionGroup.id) 
    @EarnInfrequentAmt.update_attribute(:question_type, "select") 
    @EarnInfrequentAmt.update_attribute(:answer_choices, "Yes, No") 
    @EarnInfrequentAmt.update_attribute(:question_order, "3")
    @EarnInfrequentAmt.update_attribute(:workbook_order, "108.50") 
 
    #If SsiOrCaidEarnAmt > 0
   @EarnInfrequentAmt.update_attribute(:display_rules, "
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    (SsiOrCaidEarnAmt.to_f > 0)")
 
     # now add items to insert
     #SsiOrCaidEarnAmt
       @Q_SsiOrCaidEarnAmt  = WebCalc.find_by_name('Q_SsiOrCaidEarnAmt')
       #don't want to get into the habit of rebuilding each calc if missing, need a better way, but since this is a new webcalc i'll allow it
      if @Q_SsiOrCaidEarnAmt.blank? then
         @Q_SsiOrCaidEarnAmt  = WebCalc.new(:name => 'Q_SsiOrCaidEarnAmt', :operation => "SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')")
         @Q_SsiOrCaidEarnAmt.save!
     end
 
     # calc to insert
     @VA_RateCaidWorksResourceLimit  = WebCalc.find_by_name('VA_RateCaidWorksResourceLimit')
 
     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @EarnInfrequentAmt.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @EarnInfrequentAmt.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @EarnInfrequentAmt.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @Q_SsiOrCaidEarnAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
        end
  end

  def self.down
  end
end
