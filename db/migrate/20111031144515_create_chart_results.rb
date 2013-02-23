class CreateChartResults < ActiveRecord::Migration
  def self.up
    create_table :chart_results do |t|
      t.string :name
      t.string :formula
      t.references :chart

      t.timestamps
    end
  end

  def self.down
    drop_table :chart_results
  end
end
