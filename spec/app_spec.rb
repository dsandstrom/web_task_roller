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
    context "with valid params" do
      it "redirects to /contact/success" do
        post "/contact"
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
