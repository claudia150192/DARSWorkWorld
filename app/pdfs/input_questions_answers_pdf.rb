class InputQuestionsAnswersPdf < BaseCasesPdf
  def initialize kase, groups, view
    @case = kase
    @groups = groups
    @view = view
    super "Input Questions and Answers", view do
      get_tables(@case, @groups)
    end

  end
  
  #note 2 things need fixing here
  # 1) questons get repeated in output
  
  
  #2) question without answers get placed in row
  
  def get_tables kase, groups
    groups.each do |group| 
      if(group.sub_groups.empty?)
        get_group_table(kase, group) if kase.has_answers_in?(group)
      else 
        get_tables kase, group.sub_groups
      end
    end
  end
  def get_group_table kase, group
    hdrs = get_group_headers(kase, group)
    vls = get_group_values(kase, group)
    styled_table(hdrs, vls) do |table|
      table.style(table.column(0)) {|cell| cell.width = (200)}
      table.cells.each {|cell| cell.set_width_constraints}
    end
  end
  def get_group_values kase, group
    if kase.has_answers_in? group
      results = Array.new
      group.questions.each do |question|
      #if this question appears and answered in any situation then
       if  kase.display_for_any_situation?(question) 
        text = question.all_inputs_text || question.text
        row = Array.new  
        rowCounter = 1  
        row << @view.calculate(text, kase.current_situation) unless rowCounter != 1
      
        kase.situations.each do |situation| 
          if(question.show? situation)
            answer = situation.answer_to(question)  unless situation.answer_to(question).blank?  # Bob removed this, not sure why we would show default  Saw no change. || question.default_answer_for(situation)
            row.push (answer.to_s) 
          else
            row.push ""
          end
          
        end
        results << row unless row.empty?
        end # added by RMC for kase.display_for_any_situation?(question)
      end
      return results
    end
  end
  def get_full_group_name group
    if(group.parent.nil?)
      return group.name
      else
        return "#{get_full_group_name(group.parent)} : #{group.name}" 
      end
  end
  def get_group_headers kase, group
    if kase.has_answers_in?(group)
      table_headers = Array.new
      table_headers.push(get_full_group_name(group))
      kase.situations.each do |situation| 
        table_headers.push(situation.name)
      end
      return table_headers
    end
  end
end
