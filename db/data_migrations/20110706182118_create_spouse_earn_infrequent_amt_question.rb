class CreateSpouseEarnInfrequentAmtQuestion < ActiveRecord::Migration
  def self.up
    
     #46 47	108.5	How much of the ~$SpouseSsiOrCaidEarnAmt~ that your spouse RECEIVES is infrequent or irregular?
     #	SpouseEarnInfrequentAmt			Zero or Positive Number <= SpouseSsiOrCaidEarnAmt	You can not enter an amount higher than the earned income your spouse RECEIVES (SpouseSsiOrCaidEarnAmt).  Enter positive numbers only.  Do not enter $.	0	If SpouseSsiOrCaidEarnAmt > 0	Appear	5.00	TIP NEEDED:  FOR VA MEDICAID PURPOSES, IF USER + SPOUSE'S INFREQ OR IRREG EARNED INCOME > $10, IT CANNOT BE EXCLUDED.   (See M0810.410)	113.50
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Earned Income'])
        @SpouseEarnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseEarnInfrequentAmt']) 

       if @SpouseEarnInfrequentAmt.blank? then
          @SpouseEarnInfrequentAmt = Question.new(:name => 'SpouseEarnInfrequentAmt', :text => 'SpouseEarnInfrequentAmt?', :display_rules => 'always', :default_answer => '0.00', :reference_id => '108.5',  :question_type => 'text_field', :answer_choices => '', :question_order => 3 , :group_id => @QuestionGroup.id) 
       end

       @SpouseEarnInfrequentAmt.update_attribute(:text, "How much of the ~ that your spouse RECEIVES is infrequent or irregular?") 
       @SpouseEarnInfrequentAmt.update_attribute(:default_answer, "0")
       @SpouseEarnInfrequentAmt.update_attribute(:group_id, @QuestionGroup.id) 
       @SpouseEarnInfrequentAmt.update_attribute(:question_type, "text_field") 
       @SpouseEarnInfrequentAmt.update_attribute(:answer_choices, "") 
       @SpouseEarnInfrequentAmt.update_attribute(:question_order, "3")
       @SpouseEarnInfrequentAmt.update_attribute(:workbook_order, "113.5") 
       
       #You can not enter an amount higher than the earned income your spouse RECEIVES (SpouseSsiOrCaidEarnAmt).  Enter positive numbers only.  Do not enter $.
        @SpouseEarnInfrequentAmt.update_attribute(:validation_message, "You can not enter an amount higher than the earned income your spouse RECEIVES (~).  Enter positive numbers only.  Do not enter $.") 

        # If SpouseSsiOrCaidEarnAmt > 0
      @SpouseEarnInfrequentAmt.update_attribute(:display_rules, "
        RSpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
       (RSpouseSsiOrCaidEarnAmt.to_f > 0)")
       
       #Zero or Positive Number <= SpouseSsiOrCaidEarnAmt
       @SpouseEarnInfrequentAmt.update_attribute(:validation_rules, "answer = manager.get_answer_by_question_name(self.name)
        SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
        if answer != nil then
          DoWeFloat = (true if (Float(answer) >= 0) rescue false)
          if DoWeFloat then 
            Float(answer) <= SpouseSsiOrCaidEarnAmt.to_f 
          else
            false
          end  
        else 
          true
        end
       ")
     
       # calc to insert for validation and text 
        @RSpouseSsiOrCaidEarnAmt  = WebCalc.find_by_name('RSpouseSsiOrCaidEarnAmt')
   
        #Validation insert You can not enter an amount higher than the earned income your spouse RECEIVES (SpouseSsiOrCaidEarnAmt).  Enter positive numbers only.  Do not enter $.
        @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseEarnInfrequentAmt.id, 1])
        if @Insert1.blank? then
           @Insert1  = QuestionValidationInsert.new(:question_id => @SpouseEarnInfrequentAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert1.save!
       else
         @Insert1.update_attribute(:question_id, @SpouseEarnInfrequentAmt.id)
         @Insert1.update_attribute(:insert_number, '1')
         @Insert1.update_attribute(:webcalc_id_to_insert, @RSpouseSsiOrCaidEarnAmt.id)
         @Insert1.update_attribute(:insert_marker, '~')
         @Insert1.update_attribute(:insert_type, 'currency')
        end

        #add insert to for question text [QuestionInsert table]
        @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseEarnInfrequentAmt.id, 1])
         if @Insert2.blank? then
            @Insert2  = QuestionInsert.new(:question_id => @SpouseEarnInfrequentAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert2.save!
        else
          @Insert2.update_attribute(:question_id, @SpouseEarnInfrequentAmt.id)
          @Insert2.update_attribute(:insert_number, '1')
          @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseSsiOrCaidEarnAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end

       
  end

  def self.down
  end
end
