class AddWhatIfTextToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :what_if_text, :string
    Question.all.each { |q| q.update_attribute(:what_if_text,q.text) if q.what_if_text.blank? }
  end

  def self.down
    remove_column :questions, :what_if_text
  end
end
