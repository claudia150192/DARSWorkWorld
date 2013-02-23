class AddRecordToVaMedicaidWorksTable2 < ActiveRecord::Migration
  def self.up
  
  @VaMedicaidRate =  VaMedicaidRate.create!(:start_date => Date.new(2010,01,01), 
                            :va_rate_caid_works_resource_limit => 32545.00,
                            :va_rate_caid_waiver_resource_limit => 5000.00
      )
  end

  def self.down
  end
end
