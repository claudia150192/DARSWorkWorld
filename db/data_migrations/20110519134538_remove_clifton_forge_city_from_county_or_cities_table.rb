class RemoveCliftonForgeCityFromCountyOrCitiesTable < ActiveRecord::Migration
  def self.up
     @CliftonForge        = CountyOrCity.find(:first, :conditions => ['name = ?', 'Clifton Forge City'])  
     @CliftonForge.delete unless  @CliftonForge.blank?     
  end

  def self.down
    CountyOrCity.create!(:name => 'Clifton Forge City')
  end
end
