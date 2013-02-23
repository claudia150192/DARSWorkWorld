class CreateVaMedicallyNeedyMonthlyIncomeLimits < ActiveRecord::Migration
  def self.up
    create_table :va_medically_needy_monthly_income_limits do |t|
      t.datetime :start_date
      t.integer :assist_size
      t.float :group1
      t.float :group2
      t.float :group3

      t.timestamps
    end
  end

  def self.down
    drop_table :va_medically_needy_monthly_income_limits
  end
end