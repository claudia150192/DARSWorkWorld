module WebNumericalResultsHelper  
   # Display group in the numerical results table
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  def display_numerical_group group, kase
    if kase.situations.select{ |s| group.show? s }.count > 0
      display = "<tr><th colspan='#{kase.situations.count + 1}' id='wnrg_#{group.id}'>" + group.name + "</th></tr>"
      display += display_numerical_group_results(group, kase) || ""
      display
    end
  end
  
  # Display calculation for each numerical results in the numerical results table
  # 
  # ==== Parameters
  #
  # * <tt>:group</tt> - the group being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  #"<td class='web-calc-result'> ... </td>"
  def display_numerical_group_results group, kase
    display = ""
    group.numerical_results.each do |result|
      if result.show_for? kase  
        display << "<tr><td>#{display_numerical_result_help(result)} #{result.text}</td>" unless result.result_type == 'spacer'
        kase.situations.each do |situation|
          manager = WWWebSessionManager.new(situation)
          if result.show? situation
            case result.result_type
            when "currency_detail"
              if !(result.web_calc.blank?) then
                @calcResult = number_to_currency(result.web_calc.calculate(manager).to_f)
              end
              display << "<td class='web-calc-result'>#{(result.web_calc.blank? ? '' : (@calcResult.to_s))}</td>"
        
            when "currency_total"
              if !(result.web_calc.blank?) then
                @calcResult = number_to_currency(result.web_calc.calculate(manager).to_f)
              end
              display << "<td class='web-calc-result'><b>#{(result.web_calc.blank? ? "" : (@calcResult.to_s))}</b></td>"
         
            when "string_detail"
              display << "<td>#{(result.web_calc.blank? ? '' : '' + result.web_calc.calculate(manager).to_s)}</td>"
         
            when "spacer"
              display << "<tr><td colspan='3'>&nbsp;</td></tr>"
            else
              if !(result.web_calc.blank?) then
                @calcResult = number_to_currency(result.web_calc.calculate(manager).to_f) rescue result.web_calc.calculate(manager).to_s
              end
              display << "<td class='web-calc-result'>#{(result.web_calc.blank? ? '' : (@calcResult.to_s))}</td>"
            end
          else
            display << "<td class='no-calc-result'>&nbsp;</td>"
          end
        end
        display << "</tr>"
      end
    end
    display << "<tr><td colspan='#{kase.situations.count + 1}'>&nbsp;</td></tr>"
    display
  end
  
  # Display help link for each numerical results in the numerical results table
  # 
  # ==== Parameters
  #
  # * <tt>:result</tt> - the result being displayed
  def display_numerical_result_help result
    help_link("Help?",result.help_id)
  end
end
