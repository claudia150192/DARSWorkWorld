class Situation < ActiveRecord::Base
  has_many :answers, :dependent => :destroy, :autosave => true
  belongs_to :case, :touch=>true
  belongs_to :parent, :class_name=> "Situation", :readonly=>true
  
  validates_presence_of :situation_type, :case
  validate :only_what_ifs_can_have_parents, :parent_must_be_in_the_same_case, :mode_must_be_in_hash, :type_must_be_in_hash
  
  scope :completed, where(:completed=>true)

  TYPES = { :current_situation => "current_situation", :what_if => "what_if"}
  MODES = { :group => "group", :one_at_a_time=> "one_at_a_time"}
  
  # get the answers from the session hash and save them
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def save_answers situation
    manager = WWWebSessionManager.new(situation)
    questions = manager.get_list_of_questions.find_all{|question_name| manager.question_has_been_accepted? question_name}
    question_ids = [];

    # todo: this really should not have to go through all the questions every time. we should be able to pass it a group name and limit the loop to that.
    # this also might help us figure out how to kill future things that should change b/c an answer here changed more efficiently
    questions.each do |question_name|
      question = Question.find_by_name question_name
      show_question = question.show?(self)
      answer = self.answers.find_by_question_id(question.id)
      if(show_question)
        question_ids << question.id
        if answer.nil?
          answer = Answer.create( {
            :situation => self,
            :question => question,
            :answer => manager.get_answer_by_group_and_question_name(question.group.name, question.name)
          } )
        else
          answer.answer = manager.get_answer_by_group_and_question_name(question.group.name, question.name)
          answer.save
        end
      else
        manager.remove_question question
      end
    end
    
    # destroy answers to questions that are no longer in the question list
    orphans = self.answers.find(:all, :conditions=> ['question_id not in (?)', question_ids])
    orphans.each {|answer| answer.destroy }

    self.mode = manager.get_mode
    self.answers(force_reload = true)
    self.save
  end
  
  def clear_answers
    self.answers.clear
  end
  
  def get_current_group
    group = QuestionGroup.first_displayable_parent_group self
    if group.blank?
      return nil
    end
    if group.is_parent?
      group = group.fetch_first_displayable_child self
    end
    while self.answered_all_questions_in?(group)
      group = group.fetch_next_group self
      if group.blank?
        return nil
      elsif group.is_parent?
        group = group.fetch_first_displayable_child self
      end
    end
    group
  end



  #not sure I like this, but it'll have to do
  def name
    question = Question.find_by_name("sitName")
    answer = self.answer_to question
    if answer.nil?
      a = question.default_answer_for self
    else
      a = answer.answer
    end
    return a
  end

  # return a hash of questions and answers through the use of the manager
  def retrieve_answers
    manager = WWWebSessionManager.new(self)
    self.answers.each do |answer|
      manager.add_saved_answer answer
    end
    manager.add_situation self
    manager.situation
  end

  def answer_to question
    self.answers.find_by_question_id(question.id) unless question.nil?
  end

  def unanswered_questions_from group
      Question.find(unanswered_question_ids_from group)
  end

  def on_last_question_for? group
    remaining = unanswered_question_ids_from group
    remaining.count == 1
  end

  def answered_all_questions_in? group
    if group.blank? || self.answers.empty?
      return false
    end
    unanswered_question_ids_from(group).count == 0
  end

  def has_answered_any_questions_in? group
    !answered_question_ids_from(group).empty?
  end

  def has_answered? question
    self.answers.where(:question_id => question.id).exists? unless question.blank?
  end

  def complete!
    self.update_attribute(:completed, true)
  end

  def what_if?
    self.situation_type == Situation::TYPES[:what_if]
  end

  def current_situation?
    self.situation_type == Situation::TYPES[:current_situation]
  end

  def is_in_group_mode?
    self.mode == Situation::MODES[:group]
  end

  def is_in_one_at_a_time_mode?
    self.mode == Situation::MODES[:one_at_a_time]
  end

  ## Validators
  def only_what_ifs_can_have_parents
    errors.add(:parent, "Only what-if situations can have a parent situation") unless self.parent.nil? || self.situation_type == Situation::TYPES[:what_if]
  end
  
  def parent_must_be_in_the_same_case
    errors.add(:parent, "Parent must be part of the same case as the what-if") unless self.parent.nil? || self.case == self.parent.case
  end

  def mode_must_be_in_hash
    errors.add(:mode, "Mode can only be :one_at_a_time or :group") unless MODES.has_key? self.mode.to_sym
  end

  def type_must_be_in_hash
    errors.add(:situation_type, "Situation Type can only be :current_situation or :what_if") unless TYPES.has_key? self.situation_type.to_sym
  end

private 
  def unanswered_question_ids_from group
    if group.blank?
      []
    else
      group.displayable_questions(self).map {|q| q.id} - self.answers.map{|a| a.question_id}
    end
  end

  def answered_question_ids_from group
    if group.blank?
      []
    else
      questions = group.is_child? ? group.questions : group.sub_groups.map{|sg| sg.questions}.flatten
      questions.select{ |q| self.answers.map{ |a| a.question_id}.include? q.id}
    end
  end
end
