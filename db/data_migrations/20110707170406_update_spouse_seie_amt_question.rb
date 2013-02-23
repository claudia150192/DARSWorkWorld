class UpdateSpouseSeieAmtQuestion < ActiveRecord::Migration
  def self.up
    
     #27 31 33 47	136	How much of your spouse's monthly earnings (MAX of ~SpouseSsiOrCaidEarnAmt~ OR ~SpouseWhoIsDeemedEarnAmt~) are excluded as a Student Earned Income Exclusion (SEIE)?	
     #SpouseSeieAmt			Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (the greater of SpouseSsiOrCaidEarnAmt OR SpouseWhoIsDeemedEarnAmt)	
     #Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of: 1) The maximum monthly  exclusion (~RateSEIEMaxMonthly~) minus your SEIE (~SeieAmt~); or 2) Your spouse's monthly earned income (MAX of ~SpouseSsiOrCaidEarnAmt~ OR ~SpouseWhoIsDeemedEarnAmt~).  Enter positive numbers only.  Do not enter $.	
     #EXPRESSION: the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (SpouseSsiOrCaidEarnAmt IF > 0 OR SpouseWhoIsDeemedEarnAmt IF > 0)	If SpouseStudent = Y AND (SpouseSsiOrCaidEarnAmt > 0 OR SpouseWhoIsDeemedEarnAmt > 0)	Appear	350.00	The Allowable answer: The answer to the question cannot be greater than the smaller of: (the monthly SEIE limit minus the SEIE already claimed by user) OR (the amount earned by the SSI spouse or earned by the SSI-ineligible spouse whose income is deemed).  The exclusion is same whether or not SSI actually uses the deeming calcs.	142.00
     
        @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Student Earned Income Exclusion (SEIE)'])
        @SpouseSeieAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSeieAmt']) 

       if @SpouseSeieAmt.blank? then
          @SpouseSeieAmt = Question.new(:name => 'SpouseSeieAmt', :text => 'SpouseSeieAmt?', :display_rules => 'always', :default_answer => '0.00', :reference_id => '136',  :question_type => 'text_field', :answer_choices => '', :question_order => 5 , :group_id => @QuestionGroup.id) 
       end

       @SpouseSeieAmt.update_attribute(:text, "How much of your spouse's monthly earnings (~) are excluded as a Student Earned Income Exclusion (SEIE)?") 
       @SpouseSeieAmt.update_attribute(:default_answer, "0")
       @SpouseSeieAmt.update_attribute(:group_id, @QuestionGroup.id) 
       @SpouseSeieAmt.update_attribute(:question_type, "text_field") 
       @SpouseSeieAmt.update_attribute(:answer_choices, "") 
       @SpouseSeieAmt.update_attribute(:question_order, "5")
       @SpouseSeieAmt.update_attribute(:workbook_order, "142") 
       
       #Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of: 1) The maximum monthly  exclusion (~RateSEIEMaxMonthly~) minus your SEIE (~SeieAmt~); or 2) Your spouse's monthly earned income (MAX of ~SpouseSsiOrCaidEarnAmt~ OR ~SpouseWhoIsDeemedEarnAmt~).  Enter positive numbers only.  Do not enter $.
       @SpouseSeieAmt.update_attribute(:validation_message, "Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of: 1) The maximum monthly  exclusion (~) minus your SEIE (~); or 2) Your spouse's monthly earned income (~).  Enter positive numbers only.  Do not enter $.") 

       # 7/7 If SpouseStudent = Y AND (SpouseSsiOrCaidEarnAmt > 0 OR SpouseWhoIsDeemedEarnAmt > 0)  Decided to be consistent and use Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt calc.  These questions are mutually exclusive
       @SpouseSeieAmt.update_attribute(:display_rules, "
       SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
       Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
       Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = Float(Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.calculate manager)
       (SpouseStudent == 'Yes' && Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt > 0)")

        # 7/7 EXPRESSION: the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (SpouseSsiOrCaidEarnAmt IF > 0 OR SpouseWhoIsDeemedEarnAmt IF > 0)
        
        @SpouseSeieAmt.update_attribute(:default_answer, "expression= 
        RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly')
        RateSEIEMaxMonthly = Float(RateSEIEMaxMonthly.calculate manager)
        SeieAmt = manager.get_answer_by_question_name('SeieAmt')
        if SeieAmt != nil then
         SeieAmt = Float(SeieAmt)
        else
         SeieAmt = 0
        end
         Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
         Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = Float(Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.calculate manager)
         WhatsLeft = RateSEIEMaxMonthly - SeieAmt.to_f
         answer = [ WhatsLeft, Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt].min
        ")
       
       # 7/7/2011 Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (the greater of SpouseSsiOrCaidEarnAmt OR SpouseWhoIsDeemedEarnAmt)
        @SpouseSeieAmt.update_attribute(:validation_rules, "RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly')
        RateSEIEMaxMonthly = Float(RateSEIEMaxMonthly.calculate manager)
        SeieAmt = manager.get_answer_by_question_name('SeieAmt')
        if SeieAmt != nil then
           SeieAmt = Float(SeieAmt)
        else
         SeieAmt = 0
        end
        answer = manager.get_answer_by_question_name(self.name)
        Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
        Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt = Float(Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.calculate manager)
        
        if answer != nil then
           true if (Float(answer) >= 0 && Float(answer) <= [RateSEIEMaxMonthly - SeieAmt, Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt].min) rescue false
        else 
           true
        end
        
       ")
          
       # calc to insert for validation and text 
        @RateSEIEMaxMonthly  = WebCalc.find_by_name('RateSEIEMaxMonthly')
   
        #Validation insert #Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of: 1) The maximum monthly  exclusion (~RateSEIEMaxMonthly~) minus your SEIE (~SeieAmt~); or 2) Your spouse's monthly earned income (MAX of ~SpouseSsiOrCaidEarnAmt~ OR ~SpouseWhoIsDeemedEarnAmt~).  Enter positive numbers only.  Do not enter $.
        @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieAmt.id, 1])
        if @Insert1.blank? then
           @Insert1  = QuestionValidationInsert.new(:question_id => @SpouseSeieAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RateSEIEMaxMonthly.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert1.save!
       else
         @Insert1.update_attribute(:question_id, @SpouseSeieAmt.id)
         @Insert1.update_attribute(:insert_number, '1')
         @Insert1.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxMonthly.id)
         @Insert1.update_attribute(:insert_marker, '~')
         @Insert1.update_attribute(:insert_type, 'currency')
        end

        @Q_SeieAmt  = WebCalc.find_by_name('Q_SeieAmt')
        #Validation insert 
        @InsertV2 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieAmt.id, 2])
        if @InsertV2.blank? then
           @InsertV2  = QuestionValidationInsert.new(:question_id => @SpouseSeieAmt.id, :insert_number => '2', :webcalc_id_to_insert => @Q_SeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
           @InsertV2.save!
       else
         @InsertV2.update_attribute(:question_id, @SpouseSeieAmt.id)
         @InsertV2.update_attribute(:insert_number, '2')
         @InsertV2.update_attribute(:webcalc_id_to_insert, @Q_SeieAmt.id)
         @InsertV2.update_attribute(:insert_marker, '~')
         @InsertV2.update_attribute(:insert_type, 'currency')
        end
        
        @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt  = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')
        #Validation insert 
        @InsertV3 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieAmt.id, 3])
        if @InsertV3.blank? then
           @InsertV3  = QuestionValidationInsert.new(:question_id => @SpouseSeieAmt.id, :insert_number => '3', :webcalc_id_to_insert => @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
           @InsertV3.save!
       else
         @InsertV3.update_attribute(:question_id, @SpouseSeieAmt.id)
         @InsertV3.update_attribute(:insert_number, '3')
         @InsertV3.update_attribute(:webcalc_id_to_insert, @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id)
         @InsertV3.update_attribute(:insert_marker, '~')
         @InsertV3.update_attribute(:insert_type, 'currency')
        end
              
        #add insert to for question text [QuestionInsert table]
        @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieAmt.id, 1])
         if @Insert2.blank? then
            @Insert2  = QuestionInsert.new(:question_id => @SpouseSeieAmt.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert2.save!
        else
          @Insert2.update_attribute(:question_id, @SpouseSeieAmt.id)
          @Insert2.update_attribute(:insert_number, '1')
          @Insert2.update_attribute(:webcalc_id_to_insert, @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end
    
  end

  def self.down
  end
end
