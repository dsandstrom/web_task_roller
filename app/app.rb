if %w[test development].include?(ENV.fetch("RACK_ENV"))
  require "dotenv"

  Dotenv.load(".env.#{ENV.fetch('RACK_ENV')}.local",
              ".env.#{ENV.fetch('RACK_ENV')}",
              ".env")
end

require "sinatra/content_for"

require_relative "models/email_message"
require_relative "helpers/layout_helper"
require_relative "helpers/forms_helper"

configure do
  set :app_file, "app/app"
  set :server, "puma"
end

class WebTaskRoller < Sinatra::Application
  helpers LayoutHelper, FormsHelper

  get "/" do
    erb :index
  end

  get "/workflows" do
    @title = "Status Workflows"
    erb :workflows
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
    @email_message = EmailMessage.new
    erb :contact
  end

  get "/contact/success" do
    @title = "Contact"
    erb :contact_success
  end

  post "/contact" do
    @email_message = EmailMessage.new(name: params[:contact][:name],
                                      return_email: params[:contact][:return_email],
                                      body: params[:contact][:body])

    if @email_message.deliver?
      redirect "/contact/success"
    else
      erb :contact
    end
  end
end
