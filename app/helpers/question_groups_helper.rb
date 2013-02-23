module QuestionGroupsHelper
  # Display group name as title
  def group_title group
    if group.is_parent?
      parent_group_title group
    elsif group.is_child?
      parent_group_title(group.parent) + child_group_title(group)
    end
  end
  
  def parent_group_title group
    "<h3>#{group.name}</h3>"
  end
  
  def child_group_title group
    "<h4>#{group.name}</h4>"
  end
  
  # Display Answers for each group in the summary table
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>. 
  def display_group_answers group, situation
    if group.show? situation
      display = "<tr><td>"
      if group.is_parent?
        display += group_title group
        display += "</td></tr>"
        unless group.sub_groups.blank?
          group.sub_groups.each do |sub_group|
            display += display_group_answers(sub_group, situation) || ""
          end
        else
          display += display_group_questions_answers(group, situation) || ""
        end
      elsif group.is_child?
        display += child_group_title group
        display += "</td></tr>"
        display += display_group_questions_answers(group, situation) || ""
      end
      display
    end
  end
  
  # Display Answers for each group's questions in the summary table
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  def display_group_questions_answers group, situation
    display = ""
    group.questions.each do |question|
      if situation[:groups][group.name][:questions].keys.include?(question.name)
        display += "<tr><td>" + question.text + "</td><td>" + display_question_answers(situation[:groups][group.name][:questions][question.name]) + "</td></tr>"
      end
    end
    display
  end
  
  # Display Answers for question in the summary table
  # If answer is an array, join elements
  # Otherwise just display answer as string
  # 
  # ==== Parameters
  #
  # * <tt>:answer</tt> - the answer submitted by user. 
  def display_question_answers answer
    if answer.kind_of?(Array)
      answer.join(", ")
    else
      answer
    end
  end
  
  
  # Display group in navigation side bar
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>. 
  def nav_display_group group, situation, current=false
    manager = WWWebSessionManager.new(situation)
    if group.is_nav_parent?
      if group.show?(situation) && situation != nil #&& manager.is_group_ready?(group)
        unless group.sub_groups.blank?
          current_group = " current open" if current && group.sub_groups.exists?(current)
          complete = group.sub_groups.all?{|s| situation.answered_all_questions_in?(s)} ? 'complete' : 'incomplete'
          html = "<li class='group-nav parent show#{current_group} #{complete}'>"
          html << link_to( group.name, {:controller => "situations", :action => "edit", :id=>situation.id, :group_id => group.sub_groups.first.id})
          html << display_sub_groups(group, situation)
          html << "</li>"
          raw(html)
        else
          raw("<li class='group-nav parent show #{current_group}'>"+link_to( group.name, {:controller => "situations", :action => "edit", :id=>situation.id, :group_id => group.id}) + "</li>")
        end
      else
        raw("<li class='group-nav parent no-show #{current_group}'>#{group.name}</li>")
      end
    elsif group.is_child?
      if group.show?(situation) # && manager.is_group_ready?(group)
        valid = group.validates?(situation) ? 'valid' : 'invalid'
        complete = situation.answered_all_questions_in?(group) ? 'complete' : 'incomplete'
        raw("<li class='group-nav child show #{current_group} #{valid} #{complete}'>" + link_to( group.name, {:controller => "situations", :action => "edit", :id=>situation.id, :group_id => group.id})+"</li>")
      else
        raw("<li class='group-nav child no-show #{current_group}'>#{group.name}</li>")
      end
    end
  end

  def display_sub_groups parent, situation
    html = "<ul>"
    parent.sub_groups.each do |child|
      # checking for current? might need to here
      html << nav_display_group(child, situation)
    end
    html << "</ul>"
  end
end
