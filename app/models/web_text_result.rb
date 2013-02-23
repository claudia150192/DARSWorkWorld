require 'evaluable'

class WebTextResult < ActiveRecord::Base
  validates_presence_of  :name, :text, :display_rules, :group_id
  validates_uniqueness_of :name
  belongs_to :group, :class_name => "WebTextResultsGroup"
  belongs_to :web_calc, :class_name  => "WebCalc"
   has_many :text_result_insert, :foreign_key => "recipient_id", :dependent => :destroy, :autosave => true
  acts_as_displayable
end
