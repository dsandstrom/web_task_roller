source "https://rubygems.org"

ruby "3.4.10"

gem "activemodel", "~> 8.1.4"
gem "foreman", "~> 0.90.0"
gem "mail", "~> 2.9.1"
gem "puma", "~> 8.0.2"
gem "rackup", "~> 2.3.1"
gem "sinatra", "~> 4.2.1"
gem "sinatra-contrib", "~> 4.2.1", require: false

group :development, :test do
  gem "dotenv", "~> 3.2.0", require: false
end

group :development do
  gem "guard", "~> 2.20.2", require: false
  gem "guard-bundler", "~> 3.1.0", require: false
  gem "guard-rspec", "~> 4.7.3", require: false
  # Auto reload server after file changes
  # https://github.com/alexch/rerun
  gem "rerun", "~> 0.14.0"
  gem "rubocop", "~> 1.92.0", require: false
end

group :test do
  gem "byebug", "~> 13.0.0"
  gem "rack-test", "~> 2.2.0"
  gem "rspec", "~> 3.13.2"
  gem "rspec-github", "~> 3.0.0", require: false
  gem "shoulda-matchers", "~> 8.0.1"
end
