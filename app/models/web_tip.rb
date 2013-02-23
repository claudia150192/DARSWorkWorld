require 'evaluable'

class WebTip < ActiveRecord::Base
  belongs_to :group, :class_name => "QuestionGroup"
  belongs_to :numerical_result, :class_name => "WebNumericalResult"
  validates_numericality_of :workbook_order
  acts_as_displayable
end
