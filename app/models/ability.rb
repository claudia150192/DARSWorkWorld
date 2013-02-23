# Manage user permissions using CanCan
# If user is an Admin: has permissions to everything
# If user is an registered user: has permissions to manage own account
# If user is an unregistered user: has permissions to create account and view everything

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user
    
    if user.admin?
      can :manage, :all
      can :assign_roles, User
      can :activate, User
    else
      can :read, :all
      can :create, User
      can :update, User, :id => user.id
      can :manage, User, :id => user.id
      can :create, Case
      can :manage, Case, :user_id=>user.id
      can :manage, Situation, :user_id=>user.id
    end
  end
end
