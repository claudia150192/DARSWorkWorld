class AddWebcalcToChartResult < ActiveRecord::Migration
  def self.up
    add_column :chart_results, :web_calc_id, :integer
    remove_column :chart_results, :formula
  end

  def self.down
    add_column :chart_results, :formula, :string
    remove_column :chart_results, :web_calc_id
  end
end
