source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.0'

gem 'rails'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'hashids'
gem 'chartkick'
gem 'bootstrap', '~> 4.4.1'
gem 'sprockets-rails'
gem 'will_paginate'
gem 'will_paginate-bootstrap4'
gem 'groupdate'
gem 'chronic'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'rqrcode'
gem 'lockup'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  gem 'seed_dump'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :production do
  gem 'rails_12factor', group: :production
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
