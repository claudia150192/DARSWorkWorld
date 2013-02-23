module WebTextResultsHelper  
  
  # Display group in the text results table
  # For the moment we will only have 1 group but see the possibility of dipslaying based on priority with different colors based on grouop
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  def display_text_results_for situation, groups
    display = "<div class='situation text_results'><h4>#{display_situation_title(situation)}</h4><ol>"
      groups.each do |group|
        display << display_text_group_results(group, situation)
      end
    display << "</ol></div>"
  end
  
  # Display calculation for each text results in the text results table
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  #"<td class='web-calc-result'> ... </td>"  
  def display_text_group_results group, situation
    display = ""
    group.text_results.each do |result|
      if result.show? situation
        manager = WWWebSessionManager.new(situation)
        display << "<li class='#{group.name.singularize.downcase}'>#{display_text_result_help(result)} #{group.name.singularize} - #{calculate(result.text, situation)}</li>"
      end
    end
    display
  end
  
  
  
  
  # Display help link for each text results in the text results table
  # 
  # ==== Parameters
  #
  # * <tt>:result</tt> - the result being displayed
  def display_text_result_help result
    help_link("Help?", result.help_id) 
  end 
 
end
