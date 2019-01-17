# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "cloneblt"
set :repo_url, "git@github.com:duongtnhat/cloneblt.git"
set :deploy_to, '/home/framgia/deploy'
set :scm, :git
