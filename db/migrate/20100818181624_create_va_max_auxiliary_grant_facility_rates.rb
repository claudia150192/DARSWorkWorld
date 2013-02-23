class CreateVaMaxAuxiliaryGrantFacilityRates < ActiveRecord::Migration
  def self.up
    create_table :va_max_auxiliary_grant_facility_rates do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :pd_8_amount
      t.float :elsewhere_amount
      t.float :couple_pd_8_amount
      t.float :couple_elsewhere_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :va_max_auxiliary_grant_facility_rates
  end
end
