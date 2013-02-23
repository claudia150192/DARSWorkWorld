class AddRecordToVaMedicaidWorksTable < ActiveRecord::Migration
  def self.up
    #create_table :medicaid_annual_thresholds do |t|
    # MedicaidAnnualThreshold.create!(:start_date => Date.new(2011,01,01),   This works for table named medicaid_annual_thresholds
 
    
   #   create_table :va_medicaid_rates do |t|
   #     t.datetime :start_date
   #     t.float :VA_RateCaidWorksResourceLimit
   #     t.float :VA_RateCaidWaiverResourceLimit
  # VA_RateCaidWorksResourceLimit	32545.00
  # VA_RateCaidWaiverResourceLimit	5000.00
    require 'wwweb_session_manager'    
  # @TextResultMainGroup = WebTextResultsGroup.create!(:name => 'OneForAllr1', :order => 2)   
  
  #schema says create_table "va_medicaid_rates", :force => true do |t|
  #so what is the rails way of changing the table name
  #va_medicaid_rates
  #Va_Medicaid_Rate does not work
  #Va_Medicaid_Rates does not work
  #VaMedicaidRate does not work
  #VaMedicaidRates does not work
  #vamedicaidrates does not work
  #va_medicaid_rate does not work
  #VaMedicaidsRate does not work
  
  #My best guess VaMedicaidRate does not work
     
 # @VaMedicaidRate =  VaMedicaidRate.create!(:start_date => Date.new(2010,01,01), 
 #                          :VA_RateCaidWorksResourceLimit => 32545.00,
 #                          :VA_RateCaidWaiverResourceLimit => 5000.00
 #    )

#i give up.  Perhaps the create migration and the add record migration are out of sync.  Instead i'll drop the table created by the last migration and use another pair of migrations later

  drop_table :va_medicaid_rates



  end

  def self.down
  end
end
