source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'telegram-bot'
gem 'rubocop', require: false
gem "bugsnag", "~> 6.11"
gem 'sidekiq'
gem 'redis'
gem 'redis-rails'
gem 'hiredis'
gem 'slim-rails'
gem 'auto_logger'
gem 'config'

gem 'phonelib'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', github: 'rails/webpacker' # '~> 6.0.0.pre.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'simple_form'

group :production do
  gem 'puma-plugin-systemd', github: 'deees/puma-plugin-systemd', branch: 'puma-4'
  gem 'puma-status'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'guard'
  gem 'guard-minitest'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :deploy do
  gem 'capistrano-dotenv-tasks'
  gem 'capistrano3-puma'
  gem 'capistrano', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-nvm', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-yarn', require: false
  gem 'capistrano-shell', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-systemd-multiservice', github: 'groovenauts/capistrano-systemd-multiservice', require: false
  gem 'capistrano-master-key', require: false, github: 'virgoproz/capistrano-master-key'
  gem 'capistrano-faster-assets', require: false
  #gem 'capistrano-sidekiq', require: false
  #gem 'capistrano3-puma', github: 'seuros/capistrano-puma', require: false, ref: '3e6af4f'
  gem 'capistrano-git-with-submodules'
end


gem "sorcery", "~> 0.16.0"

gem "dentaku", "~> 3.4"

gem "semver2", "~> 3.4"

gem "active_link_to", "~> 1.0"

gem "gravatarify", "~> 3.1"
