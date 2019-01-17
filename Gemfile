source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'dry_ice'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'httparty'
gem 'nokogiri'
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano3-puma'
gem 'capistrano-rvm'
