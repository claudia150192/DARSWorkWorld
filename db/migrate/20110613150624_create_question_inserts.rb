class CreateQuestionInserts < ActiveRecord::Migration
  def self.up
    create_table :question_inserts do |t|
      t.integer :question_id
      t.integer :insert_number
      t.integer :webcalc_id_to_insert
      t.string  :insert_type
      t.timestamps
    end
  end

  def self.down
    drop_table :question_inserts
  end
end
