class CreateFederalRates < ActiveRecord::Migration
  def self.up
    create_table :federal_rates do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :fbr_amount
      t.float :fbr_couple_amount
      t.float :pmv_amount
      t.float :pmv_couple_amount
      t.float :two_thirds_fbr_amount
      t.float :two_thirds_fbr_couple_amount
      t.float :services_amount
      t.float :sga_disabled_amount
      t.float :sga_blind_amount
      t.float :gen_exclude_amount
      t.float :earned_inc_disregard_amount
      t.float :seie_max_monthly
      t.float :seie_max_year
      t.float :care_b_premium
      t.float :ssi_resource_limit
      t.float :ssi_resource_limit_married

      t.timestamps
    end
  end

  def self.down
    drop_table :federal_rates
  end
end
