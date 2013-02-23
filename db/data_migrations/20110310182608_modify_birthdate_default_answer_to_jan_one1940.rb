class ModifyBirthdateDefaultAnswerToJanOne1940 < ActiveRecord::Migration
  def self.up
     @question = Question.find_by_name('BirthDate')
     @question.update_attribute(:default_answer, "01/01/1940") unless @question.blank?
  end

  def self.down
    @question = Question.find_by_name('BirthDate')
    @question.update_attribute(:default_answer, "01/01/1990") unless @question.blank?
  end
end
