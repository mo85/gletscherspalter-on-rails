Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

set :user, "gletsche"
set :rails_dir, "/home/gletsche/railsapp"

server "gletscherspalter.railsplayground.net", :anything

desc "update + restart"
task :deploy do
  update
  restart
end

desc "git pull"
task :update do
  run "cd #{rails_dir} && git pull"
end

desc "kill all dispatch.fcgi"
task :restart do 
  run "chmod 755 railsapp/public -R"
  run "pkill -9 dispatch.fcgi"
end
