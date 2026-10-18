require "spec_helper"

RSpec.describe EmailMessage, type: :model do
  include Mail::Matchers

  before do
    @email_message = EmailMessage.new(name: "Luke",
                                      return_email: "luke@example.net",
                                      body: "Message")
  end

  subject { @email_message }

  it { is_expected.to respond_to(:title) }

  describe "validations" do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(150) }
    it { is_expected.to validate_presence_of(:return_email) }
    it { is_expected.to validate_length_of(:return_email).is_at_most(150) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1000) }

    describe "for return_email format" do
      context "when value is" do
        ["nope", "no pe@example.net", "nope@", "nope@example",
         "nope@exa ple.net", "nope@example", "nope@example.n t"]
          .each do |test_email|
            it test_email do
              subject.return_email = test_email

              is_expected.not_to be_valid
            end
          end
      end

      context "when value is" do
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

  describe "#deliver?" do
    let(:mail) { double(:mail, "[]=": nil, delivery_method: nil, deliver: nil) }

    before do
      allow(Mail).to receive(:new) { mail }
    end

    context "when valid" do
      it "sends an email" do
        expect(mail).to receive(:deliver)

        subject.deliver?
      end

      it "returns true" do
        expect(subject.deliver?).to eq(true)
      end
    end

    context "when invalid" do
      before do
        subject.return_email = nil
      end

      it "doesn't send an email" do
        expect(mail).not_to receive(:deliver)

        subject.deliver?
      end

      it "returns false" do
        expect(subject.deliver?).to eq(false)
      end
    end
  end

  describe "#honeypot_activated?" do
    context "when title is nil" do
      before do
        subject.title = nil
      end

      it "returns false" do
        expect(subject.honeypot_activated?).to eq(false)
      end
    end

    context "when title is an empty string" do
      before do
        subject.title = ""
      end

      it "returns false" do
        expect(subject.honeypot_activated?).to eq(false)
      end
    end

    context "when title filled in" do
      before do
        subject.title = "something"
      end

      it "returns true" do
        expect(subject.honeypot_activated?).to eq(true)
      end
    end
  end
end
