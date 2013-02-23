class ChartResultsPdf < BaseCasesPdf
  def initialize kase, charts, view
    @case = kase
    super "Numeric Results", view do
    end

  end
  def get_charts kase, charts

  end

  def get_group_table kase, group
    table_headers = get_numeric_group_headers(kase, group)
    table_values = get_group_values(kase, group)
    chart table_headers, table_values
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

