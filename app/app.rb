require "sinatra/content_for"
require_relative "helpers/layout_helper"

configure do
  set :app_file, "app/app"
  set :server, "puma"
end

class WebTaskRoller < Sinatra::Application
  helpers LayoutHelper

  get "/" do
    erb :index
  end

  get "/workflows" do
    @title = "Status Workflows"
    erb :workflowsx
  end

  get "/features" do
    @title = "Features"
    erb :features
  end

  get "/about" do
    @title = "About"
    erb :about
  end

  get "/contact" do
    @title = "Contact"
    erb :contact
  end
end
