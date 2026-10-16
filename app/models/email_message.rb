require "active_model"

class EmailMessage
  include ActiveModel::API

  attr_accessor :name, :return_email, :message
end
