class CreateSharedCaseAuthorizedUsers < ActiveRecord::Migration
  def self.up
    create_table :shared_cases_users, :id=>false do |t|
      t.references :shared_case, :null=>false
      t.references :user, :null=>false
    end
  end

  def self.down
    drop_table :shared_case_authorized_users
  end
end
