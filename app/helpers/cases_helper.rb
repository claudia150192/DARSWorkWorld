module CasesHelper
  def display_case_question question, kase
    text = question.all_inputs_text || question.text
    calculate(text, @case.current_situation)
  end
  def display_case_answers kase, question
    display = ''
    kase.situations.each do |s|
      #todo: how do we do all the 'default answers' at once on a new current_situation?
      if question.show?(s)
        answer = s.answer_to question
        incomplete = ''
        if answer.nil?
          answer = question.default_answer_for s
          incomplete = ' incomplete'
        end
        display << "<td class='answer#{incomplete}' data-question='#{question.name}' data-situation='#{s.id}' data-group='#{question.group.name}'>#{answer}</td>"
      else
        display << "<td class='no-show' data-question='#{question.name}' data-situation='#{s.id}' data-group='#{question.group.name}'>&nbsp;</td>"
      end
    end
    display
  end
  
  def display_allinput_groups kase, groups
    colspan = kase.situations.count + 1
    html =''
    groups.each do |group|
      if kase.has_answers_in? group
        classname = group.is_parent? ? 'parent' : 'group'
        html << "<tr><th class='#{classname}' id='group_#{group.id}' colspan='#{colspan}'>#{group.name}</th></tr>"
        if group.is_parent?
          html << display_allinput_groups(kase, group.sub_groups)
        else
          group.questions.each do |q|
            if kase.display_for_any_situation?(q)
              html << "<tr><th class='question'>#{display_case_question(q,kase)}</th>"
              html << display_case_answers(kase,q)
              html << "</tr>"
            end
          end
        end
      end
    end
    raw(html)
  end

  def display_allinput_group parent
    html = ''
    unless parent.sub_groups.blank?
    html << "<li class='group-nav parent show'>"
    html << "<a href='#group_#{parent.id}'>#{parent.name}</a>" 
      html << display_allinput_subgroups(parent)
    html << "</li>"
    end
    raw(html)
  end

  def display_allinput_subgroups parent
    html = "<ul>"
    parent.sub_groups.each do |child|
      html << display_allinput_group(child)
    end
    html << "</ul>"
  end
  
  def render_continue_button situation, parents
    html = ''
    shown = situation.completed? ? ' hidden' : ''
    kase = situation.case
    html << "<form action='#{accept_all_path(:case_id=>kase.id, :id=>situation.id)}' method='post'>"
    html << "<div style='margin:0;padding:0;display:inline'><input name='_method' type='hidden' value='put'><input name='authenticity_token' type='hidden' value='#{form_authenticity_token}'></div>"
    parents.each do |p|
      groups = p.sub_groups
      groups.each do |g|
        questions = g.questions
        questions.each do |q|
          if q.show? situation 
              html << hidden_for(q,situation) 
          end
        end
      end
    end
    html << submit_tag("Accept All", :class=>"button#{shown}", :name=>"accept_all")
    html << "</form>"
    raw(html)
  end

end
