class ModifyMedicaidRateTableAddVaRateCaidLtcHomeEquityLimit < ActiveRecord::Migration
  def self.up
    
    add_column :va_medicaid_rates, :va_rate_caid_ltc_home_equity_limit, :float
  end

  def self.down
  end
end
