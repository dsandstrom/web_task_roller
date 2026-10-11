require_relative "helpers/layout_helper"

class WebTaskRoller < Sinatra::Application
  helpers LayoutHelper

  get "/" do
    erb :index
  end

  get "/about" do
    @title = "About"
    erb :about
  end
end
