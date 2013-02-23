class ChartResult < ActiveRecord::Base
  validates_presence_of :name, :chart_id
  belongs_to :chart
  belongs_to :web_calc, :class_name=>"WebCalc"
end
