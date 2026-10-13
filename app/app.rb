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

  get "/workflows/issue" do
    @title = "Issue Workflow"
    erb :issue_workflow
  end

  get "/workflows/task" do
    @title = "Task Workflow"
    erb :task_workflow
  end

  get "/features" do
    @title = "Features"
    erb :features
  end

  get "/about" do
    @title = "About"
    erb :about
  end
end
