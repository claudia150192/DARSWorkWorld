class AddOneGroupToWebTextResultsGroupTable < ActiveRecord::Migration
  def self.up
    @TextResultMainGroup = WebTextResultsGroup.new(:name => 'OneForAllr1', :order => 1)
  end

  def self.down
  end
end
