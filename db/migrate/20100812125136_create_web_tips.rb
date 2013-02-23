class CreateWebTips < ActiveRecord::Migration
  def self.up
    create_table :web_tips do |t|
      t.text :text
      t.string :identifier
      t.text :display_rules
      t.integer :group_id
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :web_tips
  end
end
