set :user, 'gletsche'

set :server, 'gletscherspalter.railsplayground.net'
set :application, "gletscherspalter-on-rails"
set :applicationdir, 'railsapp'
set :repository,  "git://github.com/mo85/gletscherspalter-on-rails.git"
set :use_suod, false

set :scm, :git
set :branch, :master

role :web, server                          # Your HTTP server, Apache/etc
role :app, server                          # This may be the same as your `Web` server
role :db,  server, :primary => true        # This is where Rails migrations will run

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