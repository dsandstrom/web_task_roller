require "active_model"

class EmailMessage
  include ActiveModel::API

  # rubocop:disable-next Layout/LineLength
  EMAIL_REGEX =
    %r{\A[a-z0-9_.!\-\#$%&'*+/=?^`{|}~]+@[a-z0-9][a-z0-9\-.]{1,62}[a-z0-9]\.[a-z]{1,20}\z}i

  attr_accessor :name, :return_email, :body

  validates :name, presence: true, length: { maximum: 150 }
  validates :return_email, presence: true, length: { maximum: 150 },
                           format: EMAIL_REGEX
  validates :body, presence: true, length: { maximum: 1000 }

  def deliver?
    return false unless valid?
    return true if ENV.fetch("RACK_ENV") == "test"

    delivery.deliver
    true
  end

  private

    def delivery
      mail = Mail.new do
        to ENV.fetch("EMAIL_ADDRESS")
        subject "Message from Website"
      end

      mail["from"] = "#{name} <#{return_email}>"
      mail["body"] = body

      setup_delivery_method(mail)
      mail
    end

    def setup_delivery_method(mail)
      mail.delivery_method :smtp,
                           address: ENV.fetch("EMAIL_HOST"),
                           port: 587,
                           domain: ENV.fetch("EMAIL_DOMAIN"),
                           user_name: ENV.fetch("EMAIL_USERNAME"),
                           password: ENV.fetch("EMAIL_PASSWORD"),
                           authentication: "plain",
                           enable_starttls_auto: true
    end
end
