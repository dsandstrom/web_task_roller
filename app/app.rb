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
    # TODO: add captcha if neccessary https://www.hcaptcha.com/
    @title = "About"
    @email_message = EmailMessage.new
    erb :about
  end

  get "/contact/success" do
    @title = "Contact"
    erb :contact_success
  end

  post "/contact" do
    @email_message = EmailMessage.new(contact_message_params)

    if @email_message.valid? && (prevent_delivery? || @email_message.deliver?)
      redirect "/contact/success"
    else
      erb :about
    end
  rescue Errno::ECONNREFUSED, KeyError => e
    logger.info "Contact form has invalid configs: #{e}"
    redirect "/contact/success"
  end

  private

    def contact_message_params
      { name: params[:contact][:name],
        return_email: params[:contact][:return_email],
        body: params[:contact][:body],
        title: params[:contact][:title],
        loaded_at: params[:contact][:loaded_at] }
    end

    def prevent_delivery?
      if @email_message.honeypot_activated?
        logger.info "Contact form honeypot activated for IP: #{request.ip}"
        return true
      elsif @email_message.submitted_too_quickly?
        logger.info "Contact form submitted too quickly for IP: #{request.ip}"
        return true
      end

      false
    end
end
