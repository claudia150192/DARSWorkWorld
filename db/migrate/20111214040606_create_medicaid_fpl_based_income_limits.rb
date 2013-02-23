class CreateMedicaidFplBasedIncomeLimits < ActiveRecord::Migration
  def self.up
    create_table :medicaid_fpl_based_income_limits do |t|
     
      t.datetime 	:start_date
      t.float 		:caid_80percent_fpl_inc_limit_assist_unit_1
      t.float 		:caid_80percent_fpl_inc_limit_assist_unit_2 
      t.float 		:caid_qmb_inc_limit_assist_unit_1
      t.float 		:caid_qmb_inc_limit_assist_unit_2
      t.float 		:caid_slmb_inc_limit_assist_unit_1
      t.float 		:caid_slmb_inc_limit_assist_unit_2
      t.float 		:caid_qi_inc_limit_assist_unit_1
      t.float 		:caid_qi_inc_limit_assist_unit_2
      t.float 		:caid_qdwi_works_earn_inc_limit_assist_unit_1
      t.float 		:caid_qdwi_works_earn_inc_limit_assist_unit_2
      
      t.timestamps
    end
  end

  def self.down
    drop_table :medicaid_fpl_based_income_limits
  end
end
