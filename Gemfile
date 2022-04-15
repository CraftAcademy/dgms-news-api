source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "3.0.0"
gem "rails", "~> 6.1.5"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "rack-cors", require: "rack/cors"
gem "devise_token_auth"
gem 'stripe-rails'

group :development, :test do
  gem 'stripe-ruby-mock', '~> 3.1.0.rc2'
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem 'simplecov', require:false
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
