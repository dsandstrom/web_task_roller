require_relative "helpers/layout_helper"

class WebTaskRoller < Sinatra::Base
  helpers do
    include LayoutHelper
  end

  get "/" do
    erb :index
  end

  get "/about" do
    @title = "About"
    erb :about
  end
end
