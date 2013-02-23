require 'evaluable'

class WebNumericalResult < ActiveRecord::Base
  validates_presence_of :name, :text, :display_rules, :group_id, :order
  validates_uniqueness_of :name
  belongs_to :group, :class_name => "WebNumericalResultsGroup"
  belongs_to :web_calc, :class_name  => "WebCalc"
  has_many :web_tips, :foreign_key => "web_numerical_result_id", :uniq => true, :order => "web_tips.group_order ASC"

  acts_as_displayable

  def show_for? kase
    kase.situations.any? { |s| show? s }
  end
end
