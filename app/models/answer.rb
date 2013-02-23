class Answer < ActiveRecord::Base
  belongs_to :situation, :touch=>true
  belongs_to :question
  
  validates_presence_of :answer, :situation, :question
  validates_uniqueness_of :question_id, :scope => :situation_id

  def to_s
    self.answer
  end
end
