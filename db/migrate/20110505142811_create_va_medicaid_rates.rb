class CreateVaMedicaidRates < ActiveRecord::Migration
  def self.up
    create_table :va_medicaid_rates do |t|
      t.datetime :start_date
      t.float :va_rate_caid_works_resource_limit
      t.float :va_rate_caid_waiver_resource_limit

      t.timestamps
    end
  end

  def self.down
    drop_table :va_medicaid_rates
  end
end
