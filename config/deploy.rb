ENV['rvm_path']||="/usr/local/rvm"
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

# Application Settings
set :application,   "wwwdev"
set :user,          "app"
set :password,      "T0sh!ba"
set :deploy_to,     "/home/#{user}/#{application}"
set :rails_env,     "production"
set :use_sudo,      false
set :keep_releases, 5

# Git Settings
set :scm,           :git
set :branch,        "master"
set :repository,    "git@github.com:ESI-VCU/wwweb.git"
set :deploy_via,    :remote_cache


#bundle settings 
require 'bundler/capistrano'
set :bundle_roles, [:app]

#fix rvm cap issues
require 'rvm'
require 'rvm/capistrano'
set(:rvm_type)          { :system }
set(:ruby_version)      { '1.9.2' }
set(:rvm_ruby_string)   { "#{ruby_version}@#{application}" }
set(:rvm_path)          { "/usr/local/rvm" }

#set :default_environment, { 
  #'PATH' => "/home/jt/.rvm/gems/ruby-1.9.2-p290@wwwdev:/home/jt/.rvm/gems/ruby-1.9.2-p290@wwwdev:/bin:$PATH",
  #'GEM_HOME'     => '/home/jt/.rvm/gems/ruby-1.9.2-p290@wwwdev',
  #'GEM_PATH'     => '/home/jt/.rvm/gems/ruby-1.9.2-p290@wwwdev',
  #'BUNDLE_PATH'  => '/home/jt/.rvm/gems/ruby-1.9.2-p290@wwwdev'
  
#}

before "deploy:setup",    "rvm:debug_gemset"
before "deploy:setup",    "bundle:install_gem"

# Uses local instead of remote server keys, good for github ssh key deploy.
ssh_options[:forward_agent] = true

# Server Roles
role :web, "128.172.188.37"
role :app, "128.172.188.37"
role :db,  "128.172.188.37", :primary => true

after 'deploy:update_code' do
  run "cd #{release_path}; cp config/database.yml.prod config/database.yml"
end

namespace :rvm do
  desc "Creates gemset for application"
  task :debug_gemset do
    disable_rvm_shell do
      run "/usr/local/rvm/bin/rvm list rubies" do |ch, stream, data|
        if stream == :err
          logger.debug "capured output on STDERR: #{data}"
        else # stream == :out
          logger.debug "capured output on STDOUT: #{data}"
        end
      end
    end    
  end
end

# We need this so that we can install rvm first!
def disable_rvm_shell(&block)
  default_shell = self[:default_shell]
  self[:default_shell] = nil
  yield
  self[:default_shell] = default_shell
end


# Passenger Deploy Reconfigure
namespace :deploy do
  desc "Restart passenger process"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} does nothing for passenger"
    task t, :roles => :app do ; end
  end

  desc "runs rake db:schema:load for current release"
  task :load_schema, :roles=>:db do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{current_release}; #{rake} RAILS_ENV=#{rails_env} db:schema:load"
  end

  desc "runs rake db:seed for current release"
  task :seed, :roles=>:db do
    rake = fetch(:rake, "rake")
    rails_env=fetch(:rails_env, "production")
    run "cd #{current_release}; #{rake} RAILS_ENV=#{rails_env} db:seed"
  end
end
