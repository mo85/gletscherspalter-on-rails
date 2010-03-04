set :user, 'gletsche'

set :server_address, 'gletscherspalter.railsplayground.net'
set :application, "gletscherspalter-on-rails"
set :applicationdir, 'railsapp'
set :repository,  "git://github.com/mo85/gletscherspalter-on-rails.git"
set :use_sudo, false

set :scm, :git
set :branch, :master

server server_address, :app, :db, :web, :primary => true

set :deploy_to, "/home/gletsche/railsapp"
set :group_writable, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

task :restart, :roles => :app do
end

task :after_update_code, :roles => [:web, :db, :app] do 
  run "chmod 755 railsapp/public -R"
  run "pkill -9 dispatch.fcgi"
end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
