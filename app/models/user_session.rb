class UserSession < Authlogic::Session::Base
  before_create :reset_persistence_token

  self.logout_on_timeout true
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  def reset_persistence_token
    record.reset_persistence_token
  end
end
