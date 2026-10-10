class WebTaskRoller < Sinatra::Base
  get "/" do
    erb :index
  end
end
