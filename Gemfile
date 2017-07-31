source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.1'
gem 'rails', '~> 5.1.1'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass'
gem 'devise'
gem 'high_voltage'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg'
gem 'simple_form'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
gem 'jquery-validation-rails'
gem "font-awesome-rails"
gem 'rails_script', '~> 2.0'
gem 'stripe-rails'
gem "figaro"
gem 'country_select'
gem "yettings"
gem "paranoia"
gem "redis"
gem "daemons"
gem 'delayed_job_active_record'
gem 'rest-client'
gem 'jquery-datetimepicker-rails'
gem 'intl-tel-input-rails'
group :development do
  gem 'better_errors'
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rvm'
  gem 'capistrano3-delayed-job'
  gem 'capistrano-rails-console', require: false
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rubocop'
end
gem 'gon'
gem 'rabl-rails'