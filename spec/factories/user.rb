Factory.define :user do |u|
  u.login "john"
  u.email "john@example.com"
  u.active true
  u.password "funkypass"
  u.password_confirmation "funkypass"
end

Factory.define :admin, :parent => :user do |u|
  u.login "admin"
  u.email "admin@example.com"
  u.admin true
  u.active true
end

Factory.define :another_user, :parent => :user do |u|
  u.login "another_user"
  u.email "another_user@example.com"
  u.active true
end
