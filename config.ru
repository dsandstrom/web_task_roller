require "rubygems"
require "bundler"

Bundler.require

require_relative "app/app"

configure do
  set :app_file, 'app/app'
end

WebTaskRoller.run!
