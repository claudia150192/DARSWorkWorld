class Case < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, :scope => :user_id
  validate :add_what_ifs_only_with_completed_current, :no_more_than_four_what_ifs, :must_have_one_and_only_one_current_situation, :can_only_have_one_incomplete_situation
  
  after_create :add_current_situation

  belongs_to :user
  has_many :situations, :class_name=>"Situation", :include=>:answers, :dependent=>:destroy, :autosave=>true, :order=>"situations.created_at"

  scope :with_completed_situation, joins(:situations).merge(Situation.completed)

  def current_situation
    self.situations.includes(:answers=>[{:question=>:group}]).find_by_situation_type(Situation::TYPES[:current_situation])
  end

  def what_ifs
    self.situations.where(:situation_type => Situation::TYPES[:what_if])
  end

  def has_unfinished_situation?
    self.situations.exists?(:completed=>false)
  end

  def situation_in_progress
    self.situations.where(:completed=>false).first
  end

  def save_as name, user = nil
    new_case = self.clone :include=>{:situations=>:answers}, :except=> [:type, {:situations=>:parent_id}] #always save as a Case
    new_case.user = user unless user.nil?
    new_case.name = disambiguate name
    new_case.created_at = DateTime.now
    new_case
  end

  def disambiguate name
    Case.disambiguate name, self.user
  end

  def self.disambiguate name, user
    if user.cases.exists?(:name=>name)
      max = user.cases.where('name LIKE ?', name + "%").collect{ |c| c.name.gsub(/[^a-zA-Z0-9\-\s]/,"").reverse.to_i}.max
      if name.index(/\(\d\)/)
        name = name.sub(/\(\d\)/,"(#{max + 1})")
      else
        name = name + " (#{max + 1})"
      end
    end
    name
  end

  def share_with users
    users = users.find_all{ |u| u.id != self.user.id}
    shared = SharedCase.new
    shared.name = disambiguate self.name + " (shared)"
    shared.authorized_users << users
    shared.user= self.user
    shared.situations << clone_situations
    shared
  end

  def build_what_if(parent)
    unless parent.blank?
      what_if = parent.dup(:include=>:answers, :except=>:parent_id)
      what_if.parent = parent
      name_q = Question.find_by_name 'sitName'
      name_answer = what_if.answers.to_a.find{|a| a.question_id == name_q.id}
      name_answer.answer = "What If #{self.what_ifs.count + 1}"
      what_if.situation_type = Situation::TYPES[:what_if]
      what_if.created_at = DateTime.now
      what_if.mode = Situation::MODES[:group]
    else
      what_if = self.situations.build(:situation_type=>Situation::TYPES[:what_if], :mode=>Situation::MODES[:group])
    end
    self.situations << what_if
    self.save
    what_if
  end

  def display_for_any_situation? question
    self.situations.any? { |s| question.show?(s) }
  end

  def has_answers_in? group
    self.situations.any?{ |s| s.has_answered_any_questions_in?(group)}
  end
  
  def can_only_have_one_incomplete_situation
    errors.add(:situations, "You cannot add a what-if scenario unless all your existing situations are completed") if self.situations.where(:completed=>false).count > 1 
  end

  def add_what_ifs_only_with_completed_current
    return if what_ifs.blank?
    errors.add(:situations, "You must complete your current situation before adding a what-if") unless current_situation.completed?
  end

  def no_more_than_four_what_ifs 
    return if what_ifs.blank?
    errors.add(:situations, "You may only have up to four what-if situations per case") unless what_ifs.count <= 4
  end

  def must_have_one_and_only_one_current_situation
      errors.add(:situations, "You must have exactly one current situation per case") unless situations.where(:situation_type=>Situation::TYPES[:current_situation]).count <= 1
  end
  
  def clone_situations
    clones = []
    self.situations.each do |s|
      clones << s.clone(:include=>:answers, :except=>:parent_id)
    end
    clones
  end

  private
  def add_current_situation
    self.situations.create(:situation_type=>Situation::TYPES[:current_situation], :mode=> Situation::MODES[:one_at_a_time]) unless self.situations.find_all { |s| s.situation_type == Situation::TYPES[:current_situation]}.count > 0
  end
end
