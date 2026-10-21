require "spec_helper"

RSpec.describe WebTaskRoller do
  def app
    WebTaskRoller
  end

  describe "root" do
    it "returns 200" do
      get "/"
      expect(last_response).to be_ok
    end
  end

  describe "GET /workflows" do
    it "returns 200" do
      get "/workflows"
      expect(last_response).to be_ok
    end
  end

  describe "GET /features" do
    it "returns 200" do
      get "/features"
      expect(last_response).to be_ok
    end
  end

  describe "GET /about" do
    it "returns 200" do
      get "/about"
      expect(last_response).to be_ok
    end
  end

  describe "POST /contact" do
    let(:mail) { double(:mail, "[]=": nil, delivery_method: nil, deliver: nil) }

    let(:valid_params) do
      { name: "Name", return_email: "test@example.net", body: "Body",
        loaded_at: (Time.now.utc - 60).to_s }
    end

    let(:invalid_params) { { name: "" } }

    before do
      allow(Mail).to receive(:new) { mail }
    end

    context "with valid params" do
      it "sends an email" do
        expect(mail).to receive(:deliver)

        post "/contact", contact: valid_params
      end

      it "redirects to /contact/success" do
        post "/contact", contact: valid_params
        expect(last_response.status).to eq(302)
        expect(last_response.location).to match("/contact/success")
      end
    end

    context "with invalid params" do
      it "doesn't send an email" do
        expect(mail).not_to receive(:deliver)

        post "/contact", contact: invalid_params
      end

      it "renders /contact" do
        post "/contact", contact: invalid_params
        expect(last_response).to be_ok
      end
    end

    context "with title filled in" do
      before do
        valid_params.merge!(title: "something")
      end

      it "doesn't send an email" do
        expect(mail).not_to receive(:deliver)

        post "/contact", contact: valid_params
      end

      it "redirects to /contact/success" do
        post "/contact", contact: valid_params
        expect(last_response.status).to eq(302)
        expect(last_response.location).to match("/contact/success")
      end
    end

    context "with invalid config" do
      before do
        allow(mail).to receive(:deliver) { raise(Errno::ECONNREFUSED) }
      end

      it "sends an email" do
        expect(mail).to receive(:deliver)

        post "/contact", contact: valid_params
      end

      it "redirects to /contact/success" do
        post "/contact", contact: valid_params
        expect(last_response.status).to eq(302)
        expect(last_response.location).to match("/contact/success")
      end
    end

    context "with missing config" do
      before do
        allow(mail).to receive(:deliver) { raise(KeyError) }
      end

      it "sends an email" do
        expect(mail).to receive(:deliver)

        post "/contact", contact: valid_params
      end

      it "redirects to /contact/success" do
        post "/contact", contact: valid_params
        expect(last_response.status).to eq(302)
        expect(last_response.location).to match("/contact/success")
      end
    end
  end

  describe "GET /contact_success" do
    it "returns 200" do
      get "/contact/success"
      expect(last_response).to be_ok
    end
  end
end
