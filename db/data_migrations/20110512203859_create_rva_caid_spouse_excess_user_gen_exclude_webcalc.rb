class CreateRvaCaidSpouseExcessUserGenExcludeWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
   
   #add new test here
   @R_VA_CaidSpouseExcessUserGenExclude = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserGenExclude')
      if @R_VA_CaidSpouseExcessUserGenExclude.blank? then
        @R_VA_CaidSpouseExcessUserGenExclude  = WebCalc.new(:name => 'R_VA_CaidSpouseExcessUserGenExclude')
      end
   
   
   # 1490	Amount of user's excess General Exclusion to subtract from spouse's unearned income	R_VA_CaidSpouseExcessUserGenExclude
   #=IF(E118>E120;E118-E120;0)
   #E118 R_VA_CaidExcessGenExclude
   #E120 R_VA_CaidEarnAmt
   
    @R_VA_CaidSpouseExcessUserGenExclude.operation = "
    R_VA_CaidExcessGenExclude = WebCalc.find_by_name('R_VA_CaidExcessGenExclude')
    R_VA_CaidExcessGenExclude = Float(R_VA_CaidExcessGenExclude.calculate manager)
    R_VA_CaidEarnAmt = WebCalc.find_by_name('R_VA_CaidEarnAmt')
    R_VA_CaidEarnAmt = Float(R_VA_CaidEarnAmt.calculate manager)
    if R_VA_CaidExcessGenExclude > R_VA_CaidEarnAmt then
      R_VA_CaidExcessGenExclude - R_VA_CaidEarnAmt
     else
       0
    end
    "
    @R_VA_CaidSpouseExcessUserGenExclude.save!
  end

  def self.down
  end
end
