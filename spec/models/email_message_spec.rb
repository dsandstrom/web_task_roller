require "spec_helper"

RSpec.describe EmailMessage, type: :model do
  before do
    @email_message = EmailMessage.new(name: "Luke",
                                      return_email: "luke@example.net",
                                      message: "Message")
  end

  subject { @email_message }

  describe "validations" do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(150) }
    it { is_expected.to validate_presence_of(:return_email) }
    it { is_expected.to validate_length_of(:return_email).is_at_most(150) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_length_of(:message).is_at_most(1000) }

    describe "for return_email format" do
      context "when email is" do
        ["nope", "no pe@example.net", "nope@", "nope@example",
         "nope@exa ple.net", "nope@example", "nope@example.n t"]
          .each do |test_email|
            it test_email do
              subject.return_email = test_email

              is_expected.not_to be_valid
            end
          end
      end

      context "when email is" do
        %w[yep@yep.yep yep_ye-p@exa-mple.ye yep123@exa.example yep123@exa.mp.le]
          .each do |test_email|
            it test_email do
              subject.return_email = test_email

              is_expected.to be_valid
            end
          end
      end
    end
  end
end
