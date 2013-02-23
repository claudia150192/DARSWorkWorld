require 'evaluable'

class WebCalc < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_one :numerical_result, :class_name => "WebNumericalResult", :foreign_key => "web_calc_id"
  
  acts_as_calculable

end
