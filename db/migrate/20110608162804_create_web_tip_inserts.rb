class CreateWebTipInserts < ActiveRecord::Migration
  def self.up
    create_table :web_tip_inserts do |t|
      t.integer :recipient_id
      t.integer :insert_number
      t.integer :webcalc_id_to_insert
      t.string  :insert_marker
       
      t.timestamps
    end
  end

  def self.down
    drop_table :web_tip_inserts
  end
end