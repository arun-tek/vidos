server '54.174.174.34', user: 'ubuntu', roles: %w[app db web], primary: 'true'
# set :deploy_to, 'home/deploy/vidos'
set :branch, 'master'
set :stage, :production
set :rails_env, :production