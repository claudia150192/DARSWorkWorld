class CreateRvaCaidSpouseExcessUserEarnedIncomeDisregardWebcalc < ActiveRecord::Migration
  def self.up
    #1600	Amount of user's excess Earned Income Disregard to subtract from spouse's earned income	R_VA_CaidSpouseExcessUserEarnedIncomeDisregard
     require 'wwweb_session_manager'  
  
  #something has really got screwed up, i'm going to redo this calc here so it can be used below.  Somehow Spouse Vars got intertwined
  
  @R_VA_CaidExcessGenExclude = WebCalc.find_by_name('R_VA_CaidExcessGenExclude ')
     if @R_VA_CaidExcessGenExclude.blank? then
       @R_VA_CaidExcessGenExclude  = WebCalc.new(:name => 'R_VA_CaidExcessGenExclude ')
     end

   #1080	Amount of General Exclusion to subtract from earned income	R_VA_CaidExcessGenExclude
   #=IF(E109>E111;E109-E111;0)
   #e109 RateGenExcludeAmt
   #e111 R_VA_CaidCountUnearnNoNeedIncomeAmt
   
   @R_VA_CaidExcessGenExclude.operation = "
   RateGeneralExclusion = WebCalc.find_by_name('RateGeneralExclusion')
   RateGeneralExclusion = Float(RateGeneralExclusion.calculate manager)
   R_VA_CaidCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt')
   R_VA_CaidCountUnearnNoNeedIncomeAmt = Float(R_VA_CaidCountUnearnNoNeedIncomeAmt.calculate manager)
   if RateGeneralExclusion > R_VA_CaidCountUnearnNoNeedIncomeAmt then
     RateGeneralExclusion - R_VA_CaidCountUnearnNoNeedIncomeAmt
    else
      0
   end
   "
   @R_VA_CaidExcessGenExclude.save!
  
    
     @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard')
        if @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.blank? then
           @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard  = WebCalc.new(:name => 'R_VA_CaidSpouseExcessUserEarnedIncomeDisregard')
        end
  #1600
    #=MAX(0;E124-MAX(0;(E120-E118)))
    #124 RateEarnedIncDisregardAmt
    #E120 R_VA_CaidEarnAmt
    #e118 R_VA_CaidExcessGenExclude
     @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.operation = "
     RateEarnedIncDisregardAmt = WebCalc.find_by_name('RateEarnedIncomeDisregard')
     RateEarnedIncDisregardAmt = Float(RateEarnedIncDisregardAmt.calculate manager)
     R_VA_CaidEarnAmt = WebCalc.find_by_name('R_VA_CaidEarnAmt')
     R_VA_CaidEarnAmt = Float(R_VA_CaidEarnAmt.calculate manager)
     R_VA_CaidExcessGenExclude = WebCalc.find_by_name('R_VA_CaidExcessGenExclude')
     R_VA_CaidExcessGenExclude = Float(R_VA_CaidExcessGenExclude.calculate manager)
     [0, (RateEarnedIncDisregardAmt - ([0, (R_VA_CaidEarnAmt - R_VA_CaidExcessGenExclude)].max))].max
     "
     @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.save!
  end

  def self.down
  end
end