class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :name
      t.string :text
      t.text :display_rules
      t.string :default_answer
      t.string :reference_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
