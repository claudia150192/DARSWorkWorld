require 'wwweb_session_manager'
module ChartsHelper
  def display_chart chart
    display = "<table id='#{chart.idify}' class='highchart' data-chart-type='#{chart.chart_type}' data-plot-options-stack='#{chart.stack_type}' data-yAxis-label='#{chart.title}' data-render-method='replace'><tbody>"
    chart.series.each do |result|
      display << chart_data_for(result, @case, chart)
    end
    display << "</tbody><thead>"
    display << chart_categories_for(@case)
    display << "</thead></table>"
    raw(display) 
  end
  def chart_categories_for kase
    display = "<tr><th></th>"
    kase.situations.each do |situation|
      display << "<th class='category'>#{display_situation_title(situation)}</th>"
    end
    return display
  end
  def chart_data_for result, kase, chart
    display = "<tr data-stack-group='0'><th class='series label'>#{result.name}</th>"
    kase.situations.each do |situation|
      if(!result.web_calc.nil?)
       manager = WWWebSessionManager.new(situation)
        display << "<td>#{result.web_calc.calculate(manager)}</td>"
      end
    end
    display << "</tr>"
    return display
  end
end
