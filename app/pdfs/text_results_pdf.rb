class TextResultsPdf < BaseCasesPdf
  def initialize kase, groups, view
    @case = kase
    @groups = groups
    @view = view
    super "Text Results", view do
      get_table(@case, @groups)
    end

  end
  def get_table kase, groups
    vals = Array.new
    hdrs = get_group_headers kase, groups
    groups.each do |group| 
      vals = vals + get_group_values(kase, group) 
    end
    styled_table(hdrs, vals) do |table|
      table.row(0).style :font_style => :bold
    end
  end
  def get_group_table kase, group
    hdrs = get_group_headers(kase, group)
    vls = get_group_values(kase, group)
  end
  def get_group_values kase, group
    results = Array.new
    show_row = false
    group.text_results.each do |result|
      row = Array.new
      kase.situations.each do |situation|
        if result.show? situation
          show_row = true
          row << "#{group.name.singularize} - #{@view.calculate(result.text, situation)}"
        else
          row << ""
        end
      end
      results << row if show_row
      show_row = false
    end
    return results
  end
  def get_group_headers kase, group
    table_headers = Array.new
    kase.situations.each do |situation| 
      table_headers << situation.name
    end
    return table_headers
  end
end

