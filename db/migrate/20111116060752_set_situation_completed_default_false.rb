class SetSituationCompletedDefaultFalse < ActiveRecord::Migration
  def self.up
    change_column_default :situations, :completed, false
    Situation.where(:completed=>nil).each do |s|
      s.completed=false
      s.save!
    end
  end

  def self.down
    change_column_default :situations, :completed,nil
  end
end
