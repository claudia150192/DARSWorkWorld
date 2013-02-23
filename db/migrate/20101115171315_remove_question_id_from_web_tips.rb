class RemoveQuestionIdFromWebTips < ActiveRecord::Migration
  def self.up
    remove_column :web_tips, :question_id
  end

  def self.down
    add_column :web_tips, :question_id, :integer
  end
end
