class CreateVaMedicaidWorksTable < ActiveRecord::Migration
  def self.up
    \
    #VA_RateCaidWorksResourceLimit
    #VA_RateCaidWaiverResourceLimit
    
    
    create_table :va_medicaid_rates do |t|
      t.datetime :start_date
      t.float :VA_RateCaidWorksResourceLimit
      t.float :VA_RateCaidWaiverResourceLimit
     
      t.timestamps
    end
      
  end

  def self.down
    drop_table :va_medicaid_rates
  end
end
