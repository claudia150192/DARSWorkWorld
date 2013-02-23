class CreateQuestionValidationInserts < ActiveRecord::Migration
  def self.up
    create_table :question_validation_inserts do |t|
      t.integer :question_id
      t.integer :insert_number
      t.integer :webcalc_id_to_insert
      t.string :insert_type
      t.string :insert_marker
      t.timestamps
    end
  end

  def self.down
    drop_table :question_validation_inserts
  end
end