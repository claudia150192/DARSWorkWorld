class ModifyCoupleSeieLessThanSeieMaxAnnualLmtReachedDisplayRule < ActiveRecord::Migration
  def self.up
     @question = Question.find_by_name('CoupleSeieLessThanSeieMaxAnnualLmtReached')
      @question.update_attribute(:display_rules,
     "Student = manager.get_answer_by_question_name('Student')
     SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
     SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
     SeieAmt = manager.get_answer_by_question_name('SeieAmt')
     if SeieAmt != nil then
       SeieAmt = Float(SeieAmt)
     else
       SeieAmt = 0
     end
     SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
     if SpouseSeieAmt != nil then
       SpouseSeieAmt = Float(SpouseSeieAmt)
     else
       SpouseSeieAmt = 0
     end
     SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
     if SsiOrCaidEarnAmt != nil then
       SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
     else
       SsiOrCaidEarnAmt = 0
     end
     SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
     if SpouseWhoIsDeemedEarnAmt != nil then
       SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
     else
       SpouseWhoIsDeemedEarnAmt = 0
     end
     SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
     if SpouseSsiOrCaidEarnAmt != nil then
      SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
     else
       SpouseSsiOrCaidEarnAmt = 0
     end
     RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly')
     RateSEIEMaxMonthly = Float(RateSEIEMaxMonthly.calculate manager)
     (Student == 'Yes' && SpouseStudent == 'Yes' && LiveWithSpouse == 'Yes' && SpouseSsiGet == 'Yes' && (SeieAmt + SpouseSeieAmt > 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > RateSEIEMaxMonthly) && ((SeieAmt + SpouseSeieAmt) < RateSEIEMaxMonthly))

    ") unless @question.blank?
  end

  def self.down
    @question = Question.find_by_name('CoupleSeieLessThanSeieMaxAnnualLmtReached')
      @question.update_attribute(:display_rules,
     "Student = manager.get_answer_by_question_name('Student')
     SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
     SeieAmt = manager.get_answer_by_question_name('SeieAmt')
     if SeieAmt != nil then
       SeieAmt = Float(SeieAmt)
     else
       SeieAmt = 0
     end
     SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
     if SpouseSeieAmt != nil then
       SpouseSeieAmt = Float(SpouseSeieAmt)
     else
       SpouseSeieAmt = 0
     end
     SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
     if SsiOrCaidEarnAmt != nil then
       SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
     else
       SsiOrCaidEarnAmt = 0
     end
     SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
     if SpouseWhoIsDeemedEarnAmt != nil then
       SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
     else
       SpouseWhoIsDeemedEarnAmt = 0
     end
     SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
     if SpouseSsiOrCaidEarnAmt != nil then
      SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
     else
       SpouseSsiOrCaidEarnAmt = 0
     end
     RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly')
     RateSEIEMaxMonthly = Float(RateSEIEMaxMonthly.calculate manager)
     (Student == 'Yes' && SpouseStudent = 'Yes' && (SeieAmt + SpouseSeieAmt > 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > RateSEIEMaxMonthly) && ((SeieAmt + SpouseSeieAmt) < RateSEIEMaxMonthly))
    ") unless @question.blank?
  end
end