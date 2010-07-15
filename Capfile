set :user, "gletsche"
set :rails_dir, "/home/gletsche/railsapp"

server "gletscherspalter.railsplayground.net", :anything

namespace :app do
  desc "Git update & restart"
  task :deploy do
    git.update
    fcgi.restart
  end
  
  desc "Remove all file caches"
  task :remove_caches do
    run "rm -rf /home/gletsche/railsapp/cache/views/"
  end
end

namespace :git do
  desc "Git update"
  task :update do
    run "cd #{rails_dir} && git pull"
  end
end

namespace :fcgi do
  desc "Restart Server"
  task :restart do 
    run "killall -9 dispatch.fcgi"
  end
end