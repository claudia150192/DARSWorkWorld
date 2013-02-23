class ModifyVaMaxAuxiliaryGrantFacilityRatesTable < ActiveRecord::Migration
  
  def self.up
    
     add_column :va_max_auxiliary_grant_facility_rates,  :ag_personal_allowance,             :float
     add_column :va_max_auxiliary_grant_facility_rates,  :ag_max_payment_pd8,                :float
     add_column :va_max_auxiliary_grant_facility_rates,  :ag_couple_max_payment_pd8,         :float
     add_column :va_max_auxiliary_grant_facility_rates,  :ag_max_payment_elsewhere,          :float
     add_column :va_max_auxiliary_grant_facility_rates,  :ag_couple_max_payment_elsewhere,   :float

     remove_column :va_max_auxiliary_grant_facility_rates, :end_date
     remove_column :va_max_auxiliary_grant_facility_rates, :pd_8_amount
     remove_column :va_max_auxiliary_grant_facility_rates, :elsewhere_amount
     remove_column :va_max_auxiliary_grant_facility_rates, :couple_pd_8_amount
     remove_column :va_max_auxiliary_grant_facility_rates, :couple_elsewhere_amount
  end

  def self.down
      add_column :va_max_auxiliary_grant_facility_rates,  :couple_elsewhere_amount,  :float
      add_column :va_max_auxiliary_grant_facility_rates,  :couple_pd_8_amount,       :float
      add_column :va_max_auxiliary_grant_facility_rates,  :elsewhere_amount,         :float
      add_column :va_max_auxiliary_grant_facility_rates,  :pd_8_amount,              :float
      add_column :va_max_auxiliary_grant_facility_rates,  :end_date,                 :datetime
 
      remove_column :va_max_auxiliary_grant_facility_rates, :ag_couple_max_payment_elsewhere
      remove_column :va_max_auxiliary_grant_facility_rates, :ag_max_payment_elsewhere
      remove_column :va_max_auxiliary_grant_facility_rates, :ag_couple_max_payment_pd8
      remove_column :va_max_auxiliary_grant_facility_rates, :ag_max_payment_pd8
      remove_column :va_max_auxiliary_grant_facility_rates, :ag_personal_allowance

  end
end
