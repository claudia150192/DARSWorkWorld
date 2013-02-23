class FixBpqyTrDisplayRule < ActiveRecord::Migration
  def self.up
    
    @TRNoBpqy = WebTextResult.find_by_name('TRNoBpqy')
    
     @TRNoBpqy.update_attribute(:display_rules, "
     BPQY = manager.get_answer_by_question_name('BPQY')
     SsiGet = manager.get_answer_by_question_name('SsiGet')
     SsdiGet = manager.get_answer_by_question_name('SsdiGet')
      BPQY != 'Yes' && (SsiGet == 'Yes' || SsdiGet == 'Yes')
     ") unless @TRNoBpqy.blank?
  end

  def self.down
  end
end
