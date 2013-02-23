class FixDoubleGeneralExclusionErrorCausedByTodaysMigration < ActiveRecord::Migration
  def self.up
    @RateGenExcludeAmt  = WebCalc.find_by_name('RateGenExcludeAmt ')
    if !(@RateGenExcludeAmt.blank?) then
      @RateGenExcludeAmt.delete
    end
  end

  def self.down
  end
end
