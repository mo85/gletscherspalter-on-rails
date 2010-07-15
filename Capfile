#Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

set :user, "gletsche"
set :rails_dir, "/home/gletsche/railsapp"

server "gletscherspalter.railsplayground.net", :anything

desc "update + restart"
task :deploy do
  update
  restart
end


namespace :git do
  desc "Git update"
  task :update do
    run "cd #{rails_dir} && git pull"
  end
end

namespace :server do
  desc "Restart Server"
  task :restart do 
    #run "chmod 755 railsapp/public -R"
    run "killall -9 dispatch.fcgi"
  end
end