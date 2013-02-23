class WWWebSessionManager
  attr_accessor :situation
  attr_accessor :current_user

  MODES = {:one_at_a_time => "one_at_a_time", :group => "group"}

  def initialize(situation, current_user = nil)
    @situation = situation
    @current_user = current_user || get_current_user
  end


  # try and retrieve the current_user from the current situation
  def get_current_user
    unless @situation.blank? || @situation.case.blank?
      @situation.case.user
    else
        nil
    end
  end

  # initialize the group-question hash for performance
  def initialize_group_hash
    if @situation[:groups].blank?
      @situation[:groups] = {}
      @situation.answers.includes(:question=>{:group=>:parent}).each do |a|
        group_name = a.question.group.name
        group = a.question.group
        question_name = a.question.name
        @situation[:groups][group_name] = group if @situation[:groups][group_name].blank?
        @situation[:groups][group_name][:questions] = {} if @situation[:groups][group_name][:questions].blank?
        @situation[:groups][group_name][:questions][question_name] = {} if @situation[:groups][group_name][:questions][question_name].blank?
        @situation[:groups][group_name][:questions][question_name] ={ 
          :answer => a.answer,
          :accepted => true 
        }
      end
    end
  end

  def initialize_group_nav
    if @situation[:nav].blank?
      parents = QuestionGroup.nav_parent_groups
      nav = {}
      parents.each { |p| nav[p.name]=p}
      groups = @situation[:groups]
      groups.each do |k,g|
        parent_name = g.parent.name
        nav[parent_name] = {} if nav[parent_name].blank?
        nav[parent_name][:subgroups] = {} if nav[parent_name][:subgroups].blank? 
        nav[parent_name][:subgroups][g.name] = g
      end
      @situation[:nav] = nav
    end
  end

  # retrieve answer from situation hash by question name
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - name of the question.
  def get_answer_by_question_name question_name
    unless @situation.blank? || @situation[:groups].blank?
      @situation[:groups].each_key do |group_name|
        unless get_answer_by_group_and_question_name(group_name, question_name).blank?
          return get_answer_by_group_and_question_name group_name, question_name
        end
      end
    end
    if !@situation.blank? && @situation.is_a?(Situation)
      question = Question.find_by_name question_name
      a= @situation.answer_to question
      unless a.blank?
        return a.answer
      end
    end
    nil
  end
  
  # retrieve answer from situation hash by question and group names
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - name of the question.
  # * <tt>:group_name</tt> - name of the group.
  def get_answer_by_group_and_question_name group_name, question_name
    unless @situation.blank? || @situation[:groups].blank?
      question_info = get_question_information_by_group_and_question_name(group_name, question_name)
      unless question_info.blank?
        question_info[:answer]
      end
    end
  end
  
  # retrieve question hash from situation hash by question and group names
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - name of the question.
  # * <tt>:group_name</tt> - name of the group.
  def get_question_information_by_group_and_question_name group_name, question_name
    unless @situation.blank? || @situation[:groups].blank?
      unless @situation[:groups][group_name].blank? || @situation[:groups][group_name][:questions].blank?
        @situation[:groups][group_name][:questions][question_name]
      end
    end
  end
  
  # retrieve question hash from situation hash by question name
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - name of the question.
  def get_question_information_by_question_name question_name
    unless @situation.blank? || @situation[:groups].blank?
      @situation[:groups].each_key do |group_name|
        unless get_question_information_by_group_and_question_name(group_name, question_name).blank?
          return get_question_information_by_group_and_question_name group_name, question_name
        end
      end
    end
    nil
  end
  
  # retrieve questions hash from situation hash by group names
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - name of the question.
  def get_questions_hash_by_group_name group_name
    unless @situation.blank? || @situation[:groups].blank? || @situation[:groups][group_name].blank?
      @situation[:groups][group_name][:questions]
    end
  end
  
  # retrieve list of all questions in the session
  def get_list_of_questions
    questions = []
    unless @situation.blank? || @situation[:groups].blank?
      @situation[:groups].each_key do |group_name|
        unless @situation[:groups][group_name].blank? || @situation[:groups][group_name][:questions].blank?
          questions << @situation[:groups][group_name][:questions].keys
        end
      end
    end
    questions.flatten
  end
  
  # pull a question out that's been Removed
  def remove_question question
    group_name = question.group.name
    unless @situation.blank? || @situation[:groups].blank? || @situation[:groups][group_name].blank? || @situation[:groups][group_name][:questions].blank?
      @situation[:groups][group_name][:questions].delete(question.name)
    end
  end

  # check if group has any questions answered 
  # 
  # ==== Parameters
  #
  # * <tt>:group_name</tt> - name of the group.
  def group_has_answers? group_name
      !(@situation[:groups].blank? || @situation[:groups][group_name].blank? || @situation[:groups][group_name][:questions].blank?)
  end
  
  # check if group has been setup in session
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup.
  def is_group_setup? group
    if group.is_parent?
      group.sub_groups.inject(false) { |setup, sub_group| setup || is_group_setup?(sub_group) }
    else
       group.more_questions_to_display? @situation
    end
  end
  
  def is_group_ready? group
    if group.is_parent?
      is_group_setup?(group) && 
      group.sub_groups.inject(false) { |setup, sub_group| setup || previous_groups_have_been_accepted?(sub_group) } && 
      group.sub_groups.inject(false) { |setup, sub_group| setup || previous_groups_are_valid?(sub_group) }
    else
      is_group_setup?(group) && previous_groups_have_been_accepted?(group) && previous_groups_are_valid?(group)
    end
  end
  
  # return a hash of questions and their default answers for a group
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  # * <tt>:mode</tt> - mode of group display
  def setup_session_for_group group, situation_model, mode = WWWebSessionManager::MODES[:one_at_a_time], user = nil
    @situation[:groups] = {} if @situation[:groups].blank?
    
    if group_has_answers?(group.name)
      names = @situation[:groups][group.name][:questions].keys
      questions = Question.find(:all, :conditions => ['name IN (?)', names], :order => 'questions.question_order ASC')
      questions.each do |question|
        if !question.show?(situation_model) || !question_is_accepted(question, @situation)
          @situation[:groups][group.name][:questions].delete(question.name)
        end
      end
    else
      @situation[:groups] = @situation[:groups].merge!({ group.name => { :id => group.id, :questions => {} }})
    end
    if mode == WWWebSessionManager::MODES[:one_at_a_time]
      question = group.get_next_displayable_question(@situation)
      @situation = add_default_question_answer(question, user) unless question.blank?
    elsif mode == WWWebSessionManager::MODES[:group]
      group.questions.each do |question|
        clear_cache(question)
        if question.show?(@situation) && !@situation[:groups][group.name][:questions].keys.include?(question.name)
          @situation = add_default_question_answer question, user
        end
      end
    end
    @situation
  end

  def clear_cache question
    question[:cache] = nil
  end
  
  def question_is_accepted question, situation
    @situation[:groups][question.group.name][:questions][question.name][:accepted]
  end

  # add question and default answer to session
  # 
  # ==== Parameters
  #
  # * <tt>:question</tt> - Question
  def add_default_question_answer question, user
    answer = user.blank? ? question.attribute_value(:default_answer, @situation) : user.default_answer(question, @situation)
    #if answer.blank?
      #answer = question.answer_choices.split(/, /).first
    #end
    @situation[:groups][question.group.name][:questions][question.name] = { 
      :answer => answer,
      :accepted => false 
    }
    @situation
  end
  
  # add question and default answer to session
  # 
  # ==== Parameters
  #
  # * <tt>:group_name</tt> - group name
  # * <tt>:question_name</tt> - question name
  # * <tt>:answer</tt> - answer
  def add_accepted_question_answer group_name, question_name, answer
    @situation[:groups][group_name][:questions][question_name] = { 
      :answer => answer, 
      :accepted => true 
    }
    @situation
  end
  
  # create the session hash with the first group
  # 
  # ==== Parameters
  #
  # * <tt>:mode</tt> - mode of group display
  def initialize_situation mode = WWWebSessionManager::MODES[:one_at_a_time], user = nil
    group = QuestionGroup.first_displayable_parent_group @situation
    unless group.blank? || group.sub_groups.blank?
      group = group.fetch_first_displayable_child @situation
    end
    unless group.blank?
      @situation = { :groups => {}, :mode => mode }
      @situation = setup_session_for_group group, mode, user
      @situation = setup_web_tips group
    end
    @situation
  end
  
  # add group answers to session
  # 
  # ==== Parameters
  #
  # * <tt>:params</tt> - hash of answers from the params object
  def add_group_answers_to_session params
    @situation[:groups] = {} if @situation[:groups].blank?
    group_name = params[:groups].keys.first
    @situation[:groups][group_name] = { :id => params[:groups][group_name][:id] } if @situation[:groups][group_name].blank?
    @situation[:groups][group_name][:questions] = {} if @situation[:groups][group_name][:questions].blank?
    names = params[:groups][group_name][:questions].keys
    questions = Question.find(:all, :conditions => ['name IN (?)', names], :order => 'questions.question_order ASC')
    questions.each do |question|
      if question.show?(@situation)
        @situation = add_accepted_question_answer group_name, question.name, params[:groups][group_name][:questions][question.name]
      end
    end unless questions.blank?
    # back-fill questions prior to the first accepted one
    @situation[:groups][group_name][:questions].keys.each do |question_name|
      if names.include? question_name
        break
      end
      @situation[:groups][group_name][:questions][question_name][:accepted] = true
    end
    @situation
  end
  
  def add_all_answers_to_session params
    @situation[:groups] = {} #if @situation[:groups].blank?
    names = params[:groups].collect { |name,group| params[:groups][name][:questions].keys }.flatten
    questions = Question.find(:all, :conditions=> ['name IN (?)', names], :order=>'questions.question_order ASC')
    questions.each do |question|
      group_name = question.group.name
      @situation[:groups][group_name] = {:questions=>{}} if @situation[:groups][group_name].blank?
      @situation = add_accepted_question_answer group_name, question.name, params[:groups][group_name][:questions][question.name]
    end unless questions.blank?
    @situation
  end

  def accept_all_answers
    @situation[:groups].each do |name, group|
      group[:questions].each do |n, question|
        question[:accepted] = true
      end
    end
    @situation
  end

  # check if question has been displayed by checking if it exsits in the session hash and has an answer
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - question name
  def question_has_been_shown? question_name
    info = get_question_information_by_question_name question_name
    !info.blank?
  end
  
  # check if question's answer has been accepted
  # 
  # ==== Parameters
  #
  # * <tt>:question_name</tt> - question name
  def question_has_been_accepted? question_name
    info = get_question_information_by_question_name question_name
    !info.blank? && info[:accepted]
  end
  
  # check if all of the group's questions' answers have been accepted
  # we only care about questions that should show
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def group_questions_have_been_accepted? group
    group.questions.each { |question| return false if question.show?(@situation) && !question_has_been_accepted?(question.name)}
    true
  end
  
  # check if all of the group's previous groups have been accepted
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def previous_groups_have_been_accepted? group
    previous_groups = []
    previous_group = group.previous_group
    while(!previous_group.blank?)
      previous_groups << previous_group
      previous_group = previous_group.previous_group
    end
    previous_groups.each { |each| return false if each.show?(@situation) && !group_questions_have_been_accepted?(each) }
    true
  end
  
  # check if all of the group's previous groups are valid
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def previous_groups_are_valid? group
    previous_groups = []
    previous_group = group.previous_group
    while(!previous_group.blank?)
      previous_groups << previous_group
      previous_group = previous_group.previous_group
    end
    previous_groups.each { |each| return false if each.show?(@situation) && !each.validates?(@situation) }
    true
  end
  
  # add answer from saved situation to hash
  # 
  # ==== Parameters
  #
  # * <tt>:answer</tt> - Answer
  def add_saved_answer answer
    @situation[:groups] = {} if @situation[:groups].blank?
    @situation[:groups][answer.question.group.name] = { :id => answer.question.group.id, :questions => {} } if @situation[:groups][answer.question.group.name].blank?
    add_accepted_question_answer answer.question.group.name, answer.question.name, answer.answer
    @situation
  end
  
  # get situation view mode from hash
  def get_mode
    @situation[:mode]
  end
  # add situation id to hash
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - Situation
  def add_situation situation
    @situation[:id] = situation.id
    @situation[:mode] = situation.mode
    @situation
  end
  
  # return the id of the saved situation
  def get_situation_id
    @situation[:id]
  end
  
  # add displayable web tips to session
  # 
  # ==== Parameters
  #
  # * <tt>:group_name</tt> - name of QuestionGroup
  # * <tt>:tip</tt> - WebTip
  # * <tt>:new_tip</tt> - boolean
  # 2/8/2010 Bob added :order => tip.order hoping to sort on it later> nOte had to remove when browser complained
# tried this too, no dice  def add_wep_tip group_name, tip, order, is_new=false
    def add_wep_tip group_name, tip, is_new=false
    @situation[:groups][group_name][:web_tips][tip.id] = { 
      :text => tip.text, 
      :new => is_new,
      :group_order => tip.group_order
    }
    @situation
  end
  #,  Removed these 2 lines from above when browser squawked
  #:order => tip.order
  
  # make sure the keys and values aren't blank
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def initialize_group_web_tips group
    @situation[:groups] = {} if @situation[:groups].blank?
    @situation[:groups][group.name] = { :id => group.id, :web_tips => {}} if @situation[:groups][group.name].blank?
    @situation[:groups][group.name][:web_tips] = { } if @situation[:groups][group.name][:web_tips].blank?
    @situation
  end 
  
  # add displayable web tips to session
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def setup_web_tips group
    initialize_group_web_tips group
    group.web_tips.each do |tip|
      @situation = add_wep_tip(group.name, tip, false) if tip.show?(@situation)
    end
    @situation
  end
  
  # update displayable web tips in session
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def update_web_tips group
    initialize_group_web_tips group
    @situation[:groups][group.name][:web_tips].keys.each do |key|
      @situation[:groups][group.name][:web_tips][key][:new] = false
    end
    @situation[:groups][group.name][:web_tips].delete_if {|key, value| 
      tip = WebTip.find_by_id(key)
      !tip.show?(@situation) 
    }
    ids = @situation[:groups][group.name][:web_tips].keys
    group.web_tips.each do |tip|
      @situation = add_wep_tip(group.name, tip, true) if(tip.show?(@situation) && !ids.include?(tip.id))
    end
    @situation
  end
  
  # get all the tips marked new
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  #added sort by On Feb 8 2010, no luck with order, settled for id for the moment
  def get_new_tips group
    @returnval = get_tips group, true
    # @returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].id} unless @situation[:groups][group.name][:web_tips].blank? 
    @returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].keys} unless @situation[:groups][group.name][:web_tips].blank? 
   #@returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].group_order} unless @situation[:groups][group.name][:web_tips].blank? 
  end
  
  # get all the tips not marked new
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  def get_non_new_tips group
    @returnval = get_tips group, false
    # @returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].id} unless @situation[:groups][group.name][:web_tips].blank?
   @returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].keys} unless @situation[:groups][group.name][:web_tips].blank?
    #@returnval = @returnval.sort_by {@situation[:groups][group.name][:web_tips].group_order} unless @situation[:groups][group.name][:web_tips].blank? 
  end
  
  # get all the tips by mark
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - QuestionGroup
  # * <tt>:new_tip</tt> - boolean
  #Replaced by RMC on June 9, 2011
 # def get_tips group, is_new=false
 #   tips = @situation[:groups][group.name][:web_tips].map { |key, value|
 #     {:id => key, :text => value[:text], :new => value[:new]} if value[:new] == is_new
 #   }.compact unless @situation[:groups].blank? || @situation[:groups][group.name].blank? || @situation[:groups][group.name][:web_tips].blank?
 # end
  
  def get_tips group, is_new=false
    tips = @situation[:groups][group.name][:web_tips].map { |key, value|
      {:id => key, :text => value[:text], :identifier => value[:identifier], :new => value[:new], :order=>value[:group_order]} if value[:new] == is_new
    }.compact unless @situation[:groups].blank? || @situation[:groups][group.name].blank? || @situation[:groups][group.name][:web_tips].blank?
    tips.sort_by{|tip| tip[:order]} unless tips.nil?
  end
  
  def get_all_tips group
    tips = @situation[:groups][group.name][:web_tips].map { |key, value|
      {:id=> key, :text=> value[:text], :identifier=>value[:identifier], :new => value[:new], :order=>value[:group_order]}
    }.compact unless @situation[:groups].blank? || @situation[:groups][group.name].blank? || @situation[:groups][group.name][:web_tips].blank?
    tips.sort_by{|tip| tip[:order]} unless tips.nil?
  end
  
  
end
