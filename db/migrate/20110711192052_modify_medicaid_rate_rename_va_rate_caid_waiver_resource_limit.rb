class ModifyMedicaidRateRenameVaRateCaidWaiverResourceLimit < ActiveRecord::Migration
  def self.up
    rename_column :va_medicaid_rates, :va_rate_caid_waiver_resource_limit, :va_rate_caid_real_estate_resource_limit 
  end

  def self.down
    rename_column :va_medicaid_rates, :va_rate_caid_real_estate_resource_limit, :va_rate_caid_waiver_resource_limit 
  end
end
