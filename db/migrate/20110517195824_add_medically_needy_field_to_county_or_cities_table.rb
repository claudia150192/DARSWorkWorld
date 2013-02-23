class AddMedicallyNeedyFieldToCountyOrCitiesTable < ActiveRecord::Migration
  def self.up
       add_column :county_or_cities, :medically_needy_group, :integer
  end

  def self.down
        remove_column :county_or_cities, :medically_needy_group
  end
 
end
