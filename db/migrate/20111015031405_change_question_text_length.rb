class ChangeQuestionTextLength < ActiveRecord::Migration
  def self.up
    change_table :questions do |t|
      t.change :text, :string, :limit=>1000
    end
  end

  def self.down
    change_table :questions do |t|
      t.change :text, :string
    end
  end
end
