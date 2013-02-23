class BaseCasesPdf < Prawn::Document
  def initialize report_name, view={}, kase={}, &block
    @case ||= kase
    @view ||= view
    @user = @case.user unless @case.nil?
    @report_name = report_name
    super() do
      content(&block)
      header(report_name)
      page_numbers
    end
  end
  def content &block
    bounding_box([bounds.left, bounds.top - 130], :width  => bounds.width, :height => bounds.height - 110) do                 
      block.call
    end
  end
  def page_numbers
    number_pages "Page <page> of <total>", { :start_count_at => 1, 
                                             :color=> '736F6E', 
                                             :page_filter => :all, 
                                             :at => [bounds.right - 140, 0],
                                             :align => :right,
                                             :size => font_size+ 1, 
                                             :height=> font_size+10 }
  end

  def header report_name
    repeat :all do
      bounding_box [bounds.left, bounds.top], :width  => bounds.width do
        text "WorkWORLD Report: #{report_name}", :align => :center, :size => font_size + 6, :font_style=> :bold
        text "Case Name: #{@case.name}   Customer Name: #{@user.login}   Counselor Name: #{@user.counselor_name}", :align => :center, :size => font_size + 1
        text "File Date/Time: #{@case.updated_at}, Print Date/Time: #{Date.today}", :align => :center, :size => font_size + 1
        move_down 5
        stroke_horizontal_rule
      end
    end
  end

  def styled_table table_headers, table_values, &block
    table_data  = Array.new
    table_data << table_headers
    table_data = table_data + table_values
    table table_data do |table|
      table.width = bounds.right
      table.header = true
      table.row(0).style :background_color => 'F8F8F8'
      table.row(0).column(0).style :font_style => :bold
      if block
        block.arity < 1 ? instance_eval(&block) : block[table]
      end
    end
    move_down 20
  end
  def file_name
    name = @report_name.strip + "_" + @case.name.strip
    name.gsub! /['`]/,""
    name.gsub! /\s*@\s*/, " at "
    name.gsub! /\s*&\s*/, " and "
    name.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  
    name.gsub! /_+/,"_"
    name.gsub! /\A[_\.]+|[_\.]+\z/,""
    return name + ".pdf"
  end
end
