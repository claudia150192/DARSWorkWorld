class AddDataToVaMedicallyNeedyMonthlyIncomeLimitTable < ActiveRecord::Migration
  def self.up
                   #va_medically_needy_monthly_income_limits
    @VaMedicaidRate1 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 1, :group1 => 280.79, :group2 => 323.99, :group3 => 421.18)
    @VaMedicaidRate2 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 2, :group1 => 357.52, :group2 => 399.00, :group3 => 507.84)
    @VaMedicaidRate3 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 3, :group1 => 421.18, :group2 => 464.38, :group3 => 572.38)    
    @VaMedicaidRate4 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 4, :group1 => 475.18, :group2 => 518.38, :group3 => 626.38) 
    @VaMedicaidRate5 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 5, :group1 => 529.18, :group2 => 572.38, :group3 => 680.38) 
    @VaMedicaidRate6 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 6, :group1 => 583.18, :group2 => 626.38, :group3 => 734.38) 
    @VaMedicaidRate7 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 7, :group1 => 637.18, :group2 => 680.38, :group3 => 788.38) 
    @VaMedicaidRate8 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 8, :group1 => 701.98, :group2 => 745.18, :group3 => 842.38)   
    @VaMedicaidRate9 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 9, :group1 => 774.55, :group2 => 817.88, :group3 => 914.95)
    @VaMedicaidRate10 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 10, :group1 => 847.12, :group2 => 890.45, :group3 => 987.52) 
    @VaMedicaidRate99 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2010,07,01), :assist_size => 99, :group1 => 72.57, :group2 => 72.57, :group3 => 72.57)    


    @VaMedicaidRate21 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 1,  :group1 => 280.79, :group2 => 323.99, :group3 => 421.18)
    @VaMedicaidRate22 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 2,  :group1 => 357.52, :group2 => 399.00, :group3 => 507.84)
    @VaMedicaidRate23 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 3,  :group1 => 421.18, :group2 => 464.38, :group3 => 572.38)    
    @VaMedicaidRate24 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 4,  :group1 => 475.18, :group2 => 518.38, :group3 => 626.38) 
    @VaMedicaidRate25 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 5,  :group1 => 529.18, :group2 => 572.38, :group3 => 680.38) 
    @VaMedicaidRate26 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 6,  :group1 => 583.18, :group2 => 626.38, :group3 => 734.38) 
    @VaMedicaidRate27 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 7,  :group1 => 637.18, :group2 => 680.38, :group3 => 788.38) 
    @VaMedicaidRate28 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 8,  :group1 => 701.98, :group2 => 745.18, :group3 => 842.38)   
    @VaMedicaidRate29 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 9,  :group1 => 774.55, :group2 => 817.88, :group3 => 914.95)
    @VaMedicaidRate30 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 10, :group1 => 847.12, :group2 => 890.45, :group3 => 987.52) 
    @VaMedicaidRate31 =  VaMedicallyNeedyMonthlyIncomeLimit.create!(:start_date => Date.new(2009,07,01), :assist_size => 99, :group1 => 72.57,  :group2 => 72.57,  :group3 => 72.57)


#the 2009 & 2010 tables look the same to me, i'll create 2 sets of tables.




         #   Medically Needy Monthly Income Levels
 #   Effective 07/01/2010 - 06/30/2011
 #
 #    Assist Size       Group I    Group II   Group III   
 #   1                 $280.79     $323.99     $421.18
 #   2                 $357.52     $399.00     $507.84
 #   3                 $421.18     $464.38     $572.38
 #   4                 $475.18     $518.38     $626.38
 #   5                 $529.18     $572.38     $680.38
 #   6                 $583.18     $626.38     $734.38
 #   7                 $637.18     $680.38     $788.38
 #   8                 $701.98     $745.18     $842.38
 #   9                 $774.55     $817.88     $914.95
 #  10                 $847.12     $890.45     $987.52
 #  99                  $72.57      $72.57      $72.57 [additional]
 
 #
 #
 
#     create_table :va_medically_needy_monthly_income_limits do |t|
#       t.datetime :start_date
#       t.integer :assist_size
#       t.float :group1
#       t.float :group2
#       t.float :group3
 
 #
 #
 #
 #
 #
 #
 # 
  end

  def self.down
  
    @rate2009 = VaMedicallyNeedyMonthlyIncomeLimit.find(:all, :conditions => ['start_date = ?',  Date.new(2009,07,01)])
    @rate2009.delete

    @rate2010 = VaMedicallyNeedyMonthlyIncomeLimit.find(:all, :conditions => ['start_date = ?',  Date.new(2010,07,01)])
    @rate2010.delete
    
    
    
  end
end
