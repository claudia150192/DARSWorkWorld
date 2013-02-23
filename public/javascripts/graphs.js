/**
 * Created by JetBrains WebStorm.
 * User: pvencill
 * Date: 10/31/11
 * Time: 12:34 AM
 * To change this template use File | Settings | File Templates.
 */

VcuChart = function $C(el){
    return this.renderChartFor(el);
}

VcuChart.prototype.renderChartFor = function VcuChart$renderChartFor(el){
    var self = this;
    var chartId = 'chart_'+el.attr('id');
    el.before('<div id="'+chartId+'"></div>');
    
    var chart = new Highcharts.Chart({
       chart:{
           renderTo: chartId,
           type: el.attr('data-chart-type')
       },
        title: {
            text: ''
        },
        plotOptions:{
            column:{
                stacking: el.attr('data-plot-options-stack')
            }
        },
        xAxis:{
            categories: self.getCategories(el)
        },
        yAxis:{
            title: {
                text: el.attr('data-yAxis-label')
            }
        },
        series : self.getSeries(el)
    });
    
    if(el.attr('data-render-method') == 'replace')
        el.remove();
    return chart;
};

VcuChart.prototype.getCategories = function VcuChart$getCategories(el){
    var headers = el.find('thead th.category');
    var categories = [];
    headers.each(function(idx){
        categories.push($(this).text())
    })
    return categories;
}

VcuChart.prototype.getSeries = function VcuChart$getSeries(el){
    var series = [];
    var rows = el.find('tbody tr');
    rows.each(function(idx){
       var row = $(this);
       var s = { name : row.find('th.label').text(), data : []};
       row.find('td').each(function(idx){
            s.data.push(parseFloat($(this).text()));
       });
       var stack = row.attr('data-stack-group');
       if(stack)
        s.stack = parseInt(stack);
       series.push(s);
    });
    return series;
}

$(document).ready(function() {
    var charts = $('.highchart').each(function(idx){
        var el = $(this);
        var c = new VcuChart(el);
    });
      /*var chart1 = new Highcharts.Chart({
         chart: {
            renderTo: 'current_situation_chart',
            type: 'bar'
         },
         title: {
            text: 'Fruit Consumption'
         },
         xAxis: {
            categories: ['Apples', 'Bananas', 'Oranges']
         },
         yAxis: {
            title: {
               text: 'Fruit eaten'
            }
         },
         series: [{
            name: 'Jane',
            data: [1, 0, 4]
         }, {
            name: 'John',
            data: [5, 7, 3]
         }]
      });*/
    $('#charts q').remove();
   });