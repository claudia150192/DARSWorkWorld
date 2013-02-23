class AllowRubyExpressionInDefaultField < ActiveRecord::Migration
  def self.up
    change_column :questions, :default_answer, :text
  end

  def self.down
    change_column :questions, :default_answer, :string
  end
end
