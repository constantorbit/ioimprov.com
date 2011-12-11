set :stages, %w(production staging)
set :default_stage, 'production'
require 'capistrano/ext/multistage'

##### APPLICATION #####
  set :repository,  "git@github.com:matthooks/ioimprov.com.git"

##### SOURCE CONTROL #####
  set :scm, "git"
  set :branch, "master"

##### SERVER #####
  set :use_sudo, false

##### DEPLOYMENT #####
  set(:deploy_to) { "/home/#{user}/public_html/#{application}" }
  set :deploy_via, :remote_cache

  role(:app)  { domain }
  role(:web)  { domain }
  role(:db)   { domain }

  ssh_options[:forward_agent] = true
  default_run_options[:pty] = true

##### TASKS #####
  after "deploy", "deploy:cleanup"

  desc "Streams the (production|error|access) log."
  task :tail_log, :roles => :app do
    file = ENV['FILE'] || rails_env
    stream "tail -f #{shared_path}/log/#{file}.log"
  end

  # Redefine deploy task for use with Passenger
  namespace :deploy do
    desc "Restart Passenger based Application"
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt"
    end

    [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do; end
    end
  end

##### MAC OS X SSH SETTINGS #####
  on :start do
    `ssh-add`
  end