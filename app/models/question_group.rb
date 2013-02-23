class QuestionGroup < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :workbook_order
  has_many :sub_groups, :class_name => "QuestionGroup", :foreign_key => "parent_id", :uniq => true, :dependent => :destroy, :autosave => :true
  belongs_to :parent, :class_name => "QuestionGroup"
  has_many :questions, :foreign_key => "group_id", :uniq => true, :dependent => :destroy, :autosave => true, :order => "questions.question_order ASC"
  #has_many :questions, :foreign_key => "group_id", :uniq => true, :dependent => :destroy, :autosave => true
  belongs_to :next_group, :class_name => "QuestionGroup", :foreign_key => "next_group_id"
  has_one :previous_group, :class_name => "QuestionGroup", :foreign_key => "next_group_id"
  has_many :web_tips, :foreign_key => "group_id", :uniq => true, :order => "web_tips.group_order ASC"
  scope :nav_parents, where(:parent_id=>nil).joins(:sub_groups)
  scope :child_groups, where("parent_id IS NOT NULL").joins(:parent).joins(:questions)

####### TODO: look at optimizing here; might be able to gain by eager loading sub_groups, or by not diogn the map stuff in parent_groups, etc.  

  def is_parent?
    parent_id.blank? && !self.sub_groups.blank?
  end

  def has_children?
    !self.sub_groups.empty?
  end

  # if parent_id is blank, then group must be a parent group
  def is_nav_parent?
    parent_id.blank?
  end
  
  # if parent_id is not blank, then group must be a child group
  def is_child?
    !is_parent?
  end
  
  # get all the parent groups (excludes first group)
  def self.parent_groups
    all = QuestionGroup.includes(:sub_groups).all(:order => '"order" ASC')
    all.map do |group|
      group if group.is_nav_parent? # && !group.previous_group.blank?
    end.compact
  end
  
  # get all the parents for navigation
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def self.nav_parent_groups
    parents = []
    #parents << QuestionGroup.first_displayable_parent_group(situation)
    parents << QuestionGroup.parent_groups
    parents.flatten
  end

  # get first displayable parent group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def self.first_displayable_parent_group situation
    group = QuestionGroup.find(:first, :conditions => [ 'parent_id IS NULL AND "order" IS NOT NULL'], :order => '"order" ASC')
    if !group.blank? && group.show?(situation)
      group
    elsif !group.blank?
      group.fetch_next_group(situation)
    end
  end
  
  # figure out if group should show
  # if at least one question in the group or the group's subgroups shows, then groups should show
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def show? situation
    ## TODO: more optimization?  there's 10 seconds to be had in here
    if self.is_parent?
      return self.sub_groups.inject(false) { |show, group| show || group.show?(situation) }
    else
      self.questions.each do |question|
        if question.show?(situation)
          return true
        end
      end
    end
    return false
  end
  
  # fetch next 'showable' group in the workflow
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def fetch_next_group situation
    if self.next_group.blank?
      nil
    else
      next_group = self.next_group.is_parent? ? self.next_group.sub_groups.order("workbook_order").first : self.next_group
      if !next_group.blank? && next_group.show?(situation)
        next_group
      else
        next_group.fetch_next_group(situation)
      end
    end
  end
  
  # fetch first 'showable' sub group for a parent group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def fetch_first_displayable_child situation
    if self.is_parent?
      child_group = self.sub_groups.first
      while( !child_group.blank? && !child_group.show?(situation) )
        child_group = child_group.next_group
      end
      return child_group
    end
    return nil
  end
  
  # figure out if group validates
  # if at least one question in the group or the group's subgroups does noe validate, then the group does not validate
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def validates? situation
    valid = true
    manager = WWWebSessionManager.new(situation)
    if self.is_parent?
      return self.sub_groups.inject(false) { |validates, group| validates || group.validates?(situation) }
    else
      self.questions.each do |question|
        if manager.question_has_been_shown?(question.name) && question.show?(situation)
          valid = valid && question.validates?(situation)
        end
      end
    end
    return valid
  end
  
  # check if the group has any validation errors
  # if one question has validation errors, then the groups has validation errors
  def has_validation_errors?
    if self.is_parent?
      return self.sub_groups.inject(false) { |result, group| result || group.has_validation_errors? }
    else
      self.questions.each do |question|
        if question.has_validation_errors?
          return true
        end
      end
    end
    return false
  end
  
  # return the first question in order that can be shown
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def get_first_displayable_question situation
    get_next_displayable_question situation
  end
  
  # get the next displayable question that is not in array
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  # * <tt>:excluded_questions</tt> - an array of questions to exclude
  def get_next_displayable_question situation
    questions_list = self.questions.map { |question| question }
    question = questions_list.shift
    manager = WWWebSessionManager.new(situation)
    hash = manager.get_questions_hash_by_group_name(self.name)
    excluded_questions = hash.blank? ? [] : hash.keys
    while !question.blank? && ( !question.show?(situation) || excluded_questions.include?(question.name) )
      question = questions_list.shift
    end
    question
  end
  
  # check if there is at least one more displayable question for group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  # * <tt>:excluded_questions</tt> - an array of questions to exclude
  def more_questions_to_display? situation
    !get_next_displayable_question(situation).blank?
  end
  
  # check if there is at least one more displayable question for all groups
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  # * <tt>:excluded_questions</tt> - an array of questions to exclude
  def self.more_questions_to_display? situation
    group = QuestionGroup.first_displayable_parent_group situation
    while( !group.blank? ) do
      if group.more_questions_to_display?(situation) == true
        return true
      else
        group = group.fetch_next_group situation
      end
    end
    false
  end
  
  # check if there is at least one invalid group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  # * <tt>:excluded_questions</tt> - an array of questions to exclude
  def self.invalid_groups? situation
    groups = QuestionGroup.all(:order => "question_groups.order ASC")
    groups.each { |group| return true if group.show?(situation) && !group.validates?(situation) }
    false
  end
  
  def displayable_questions situation
    questions.find_all { |q| q.show?(situation)}
  end
end
