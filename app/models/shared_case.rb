class SharedCase < Case
  has_and_belongs_to_many :authorized_users, :class_name => 'User'
 
  validate :not_modifiable, :on=> :update

  protected
  def not_modifiable
    errors[:base] << "Shared Cases are read-only once created"
  end
end
