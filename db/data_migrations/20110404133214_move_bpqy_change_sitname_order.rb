class MoveBpqyChangeSitnameOrder < ActiveRecord::Migration
  def self.up
    @questionBPQY = Question.find_by_name('BPQY')
    @questionBPQY.update_attribute(:group_id, '63855') unless @questionBPQY.blank?
    @questionBPQY.update_attribute(:question_order, '7') unless @questionBPQY.blank?
    @questionBPQY.update_attribute(:display_rules, "Blind = manager.get_answer_by_question_name('Blind')
    Disability = manager.get_answer_by_question_name('Disability') 
    Blind == 'Yes' || Disability == 'Yes'") unless @questionBPQY.blank?
       
    @questionSitName = Question.find_by_name('SitName')
    @questionSitName.update_attribute(:question_order, '8') unless @questionSitName.blank?
    #decided to get a bit lazy, the Current date, even though its not a question is taking up an order number, let it stay for now
    
  end

  def self.down
  end
end