class AddOneGroupToTextResultGroupTable < ActiveRecord::Migration
  def self.up
      @TextResultMainGroup = WebTextResultsGroup.create!(:name => 'OneForAllr1', :order => 2)
  end

  def self.down
  end
end
