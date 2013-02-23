class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.string :chart_type
      t.string :title
      t.string :yaxis_label

      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
