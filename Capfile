set :user, "gletsche"
set :rails_dir, "/home/gletsche/railsapp"

server "gletscherspalter.railsplayground.net", :anything

namespace :app do
  desc "Git update, Rake db:migrate & restart"
  task :deploy do
    git.update
    app.migrate
    passenger.restart
  end
  
  desc "Remove all file caches"
  task :remove_caches do
    run "rm -rf /home/gletsche/railsapp/cache/views/"
  end
  
  desc "Run any migrations left"
  task :migrate do
    run "cd #{rails_dir} && RAILS_ENV=production rake db:migrate"
  end
  
end

namespace :git do
  desc "Git update"
  task :update do
    run "cd #{rails_dir} && git pull"
  end
end

namespace :passenger do
  desc "Restart Server"
  task :restart do 
    run "touch railsapp/tmp/restart.txt"
  end
end