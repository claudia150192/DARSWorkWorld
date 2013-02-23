class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :answer
      t.integer :question_id
      t.integer :situation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end