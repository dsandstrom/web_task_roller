require "active_model"

class EmailMessage
  include ActiveModel::API

  # rubocop:disable Layout/LineLength
  EMAIL_REGEX =
    %r{\A[a-z0-9_.!\-\#$%&'*+/=?^`{|}~]+@[a-z0-9][a-z0-9\-.]{1,62}[a-z0-9]\.[a-z]{1,20}\z}i.freeze
  # rubocop:enable Layout/LineLength

  attr_accessor :name, :return_email, :message

  validates :name, presence: true, length: { maximum: 150 }
  validates :return_email, presence: true, length: { maximum: 150 },
                           format: EMAIL_REGEX
  validates :message, presence: true, length: { maximum: 1000 }
end
