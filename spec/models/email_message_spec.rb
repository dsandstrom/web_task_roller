require "spec_helper"

RSpec.describe EmailMessage do
  before do
    @email_message = EmailMessage.new(name: "Luke",
                                      return_email: "luke@example.net",
                                      message: "Message")
  end

  subject { @email_message }

  it { is_expected.to be_valid }
end
