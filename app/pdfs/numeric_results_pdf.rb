class NumericResultsPdf < BaseCasesPdf
  def initialize kase, groups, view
    @case = kase
    @groups = groups
    super "Numeric Results", view do
      get_tables(@case, @groups)
    end

  end
  def get_tables kase, groups
    
   # groups.each { |group| get_group_table(kase, group)} unless groups.each { |group| group.numerical_results.result.show_for? kase }
  
  groups.each { |group| get_group_table(kase, group)} 
 
 end

##need this for later to eliminate rows that should not print because admin only
## will have a "if result.show_for? kase" flavor
# def group_show_for_admin kase, group
#   
#   
# end

  def get_group_table kase, group
      table_headers = get_numeric_group_headers(kase, group)
      table_values = get_group_values(kase, group)
      styled_table(table_headers, table_values) do |table|
        table.style(table.column(0)) {|cell| cell.width = (170)}
        table.cells.each {|cell| cell.set_width_constraints}
      end
    end
  
  def get_group_values kase, group
    table_rows = Array.new
    group.numerical_results.each do |result|
     @table_row = Array.new
      if result.show_for? kase
        question_name = result.result_type != 'spacer' ? (result.text.to_s) : ''
        @table_row << question_name
        kase.situations.each do |situation|
          @table_cell = ""
          manager = WWWebSessionManager.new(situation)
          if result.show? situation
            case result.result_type
            when "currency_detail"
              if !(result.web_calc.blank?) then
                @calcResult = (@view.number_to_currency(result.web_calc.calculate(manager).to_f)).to_s
              end
            when "currency_total"
              if !(result.web_calc.blank?) then
                @calcResult = (@view.number_to_currency(result.web_calc.calculate(manager).to_f).to_s)
              end
            when "string_detail"
              @table_cell =  (result.web_calc.blank? ? '' :  result.web_calc.calculate(manager).to_s)
            when "spacer"
              @table_cell = ""
            else
              if !(result.web_calc.blank?) then
                @calcResult = (number_to_currency(result.web_calc.calculate(manager).to_f)) rescue (result.web_calc.calculate(manager)).to_s
              end
            end
            @table_cell = @calcResult.to_s
          else
            @table_cell =  "N/A"
          end
          @table_row << @table_cell.to_s
        end
        table_rows.push(@table_row)
      end
    end
    return table_rows
  end
  def get_full_numeric_group_name group
    group.name.to_s
    unless group.nil? || group.name.empty?
      group_name = group.name.to_s
    end
    if (group_name.nil? || !group_name.is_a?(String))
      group_name = ""
    end
    return group_name
  end
  def get_numeric_group_headers kase, group
    table_headers = Array.new
    header_name = get_full_numeric_group_name(group).to_s
    table_headers.push(header_name)
    kase.situations.each do |situation| 
      table_headers << situation.name
    end
    return table_headers
  end
end

