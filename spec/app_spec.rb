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

  describe "/workflows" do
    it "returns 200" do
      get "/workflows"
      expect(last_response).to be_ok
    end
  end

  describe "/features" do
    it "returns 200" do
      get "/features"
      expect(last_response).to be_ok
    end
  end

  describe "/about" do
    it "returns 200" do
      get "/about"
      expect(last_response).to be_ok
    end
  end

  describe "/contact" do
    it "returns 200" do
      get "/contact"
      expect(last_response).to be_ok
    end
  end
end
