require 'evaluable'

class Question < ActiveRecord::Base
  validates_presence_of :name, :text, :display_rules, :group_id, :question_type, :question_order
  validates_uniqueness_of :name
  belongs_to :group, :class_name => "QuestionGroup"
  has_many :web_tips, :foreign_key => "question_id", :uniq => true, :order => "web_tips.group_order ASC"
  before_save :set_defaults

  acts_as_displayable
  acts_as_validatable
  acts_as_expressionable :fields => [:default_answer]
  
  # return a browser friendly id composed of the group name and question name
  def idify
    "#{self.group.name.gsub(/[ ]/, '').underscore}_#{self.name.gsub(/[ ]/, '').underscore}"
  end

  def default_answer_for(situation)
    
    @situation = situation
    
    # get the question-level default answer
    if self.is_expression? "default_answer"
      default = self.eval_expression("default_answer",@situation)
    else
      default = self.default_answer
    end
    
    # look into other sources for the default unless the question wants to always use its own or if the situation is blank
    unless self.force_default? || situation.blank?
      default = default_from_parent(situation) || default
    end
    default
  end

  def default_from_parent situation
    default = nil
    unless situation.parent.blank?
      answer = situation.parent.answer_to self
      default = answer.answer unless answer.nil?
    end
    default
  end

  # deprecated
  def default_from_prior_case situation
    default = nil
    if situation.current_situation?
      user = situation.case.user
      last_case = Case.with_completed_situation.where(:user_id => user).first
      unless last_case.nil?
        answer = last_case.current_situation.answer_to self
        default = answer.answer unless answer.nil?
      end
    end
    default
  end

  def appropriate_text_for(situation)
      self.text
  end

  def set_defaults
  #  self.all_inputs_text = self.text if self.all_inputs_text.blank?
  end
end
