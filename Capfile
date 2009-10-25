load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

task :restart, :roles => :app do
end

task :after_update_code, :roles => [:web, :db, :app] do 
  run "chmod 755 railsapp/public -R"
  run "pkill -9 dispatch.fcgi"
end