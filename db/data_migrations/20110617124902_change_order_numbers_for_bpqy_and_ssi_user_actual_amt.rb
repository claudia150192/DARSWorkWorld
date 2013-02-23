class ChangeOrderNumbersForBpqyAndSsiUserActualAmt < ActiveRecord::Migration
  def self.up
     

      @BPQY                      = Question.find(:first, :conditions => ['name = ?',  'BPQY'])
      @SsiUserActualAmt          = Question.find(:first, :conditions => ['name = ?',  'SsiUserActualAmt'])
      
      @BPQY.update_attribute(:workbook_order, "6.5")   unless @BPQY.blank?            
      @SsiUserActualAmt.update_attribute(:workbook_order, "28.70")   unless @SsiUserActualAmt.blank?     
     
     
     # 25 41	181	What is the actual amount of your monthly SSI payment ? (Do not count payment amounts to other family members, if any.)	SsiUserActualAmt			Zero or Positive Number 	Enter positive numbers only.  Do not enter $.	0	If Current/What-If Button = Current AND SsiGet = Y	no		We moved this back because finding the question was not intuitive since it was not in the SSI question group.	28.70
     #SsiUserActualAmt 	What is the actual amount of your monthly SSI payment? (Do not count payment amounts to other family members, if any.) 	SsiGet = manager.get_answer_by_question_name('SsiGet') SsiGet == 'Yes' 	181 	SSI 	text_field 		0.00 	4 	answer = manager.get_answer_by_question_name(self.name) if answer != nil then true if (Float(answer) >= 0) rescue false else true end 	Enter positive numbers only. Do not enter $. 		187.0
  end

  def self.down
  end
end
