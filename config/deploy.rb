# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "vidos"
set :repo_url, "git@github.com:arun-tek/vidos.git"

# Default value for :linked_files is []
append :linked_files, %w[config/database.yml config/master.key]

# Default value for linked_dirs is []
append :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads node_modules]

# Default value for keep_releases is 5
set :keep_releases, 3

# Skip migration if files in db/migrate were not modified
# Defaults to false
set :conditionally_migrate, true
set :stage, :production
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }


# ================================================
# ============ From Custom Rake Tasks ============
# ================================================
# ===== See Inside: lib/capistrano/tasks =========
# ================================================

# upload configuration files
before 'deploy:starting', 'config_files:upload'

set :initial, true

# run only if app is being deployed for the very first time, should update "set :initial, true" above to run this
before 'deploy:migrate', 'database:create' if fetch(:initial)

# reload application after successful deploy
after 'deploy:publishing', 'application:reload'