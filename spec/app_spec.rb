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

  describe "GET /contact" do
    it "returns 200" do
      get "/contact"
      expect(last_response).to be_ok
    end
  end

  describe "POST /contact" do
    let(:valid_params) do
      { name: "Name", email: "test@example.net", body: "Body" }
    end

    let(:invalid_params) { { name: "" } }

    context "with valid params" do
      it "redirects to /contact/success" do
        post "/contact", contact: valid_params
        expect(last_response.status).to eq(302)
        expect(last_response.location).to match("/contact/success")
      end
    end

    context "with invalid params" do
      it "renders /contact" do
        post "/contact", contact: invalid_params
        expect(last_response).to be_ok
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
