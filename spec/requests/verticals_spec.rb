# spec/requests/verticals_spec.rb
require 'rails_helper'

RSpec.describe "Verticals API", type: :request do
  let(:application) { create(:oauth_application) }
  let(:access_token) { create(:access_token, application: application) }

  describe "GET /api/v1/verticals" do

    context "when the request is authorized" do
      it "returns a 200 status code" do
        get api_v1_verticals_path, headers: { Authorization: "Bearer #{access_token.token}" }
        expect(response).to have_http_status(:ok)
      end

      it "returns the list of verticals" do
        create(:vertical, name: "Health & Fitness")
        create(:vertical, name: "Business")

        get api_v1_verticals_path, headers: { Authorization: "Bearer #{access_token.token}" }
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end

    context "when the request is unauthorized" do
      it "returns a 401 status code if token is missing" do
        get api_v1_verticals_path
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a 401 status code if token is invalid" do
        get api_v1_verticals_path, headers: { Authorization: "Bearer invalid_token" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /api/v1/verticals" do
    context "when the request is authorized" do
      let(:valid_attributes) { { vertical: { name: "Health & Wellness" } } }

      it "creates a new vertical" do
        expect {
          post api_v1_verticals_path, params: valid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
        }.to change(Vertical, :count).by(1)
      end

      it "returns a 201 status code" do
        post api_v1_verticals_path, params: valid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is unauthorized" do
      let(:invalid_attributes) { { vertical: { name: "Business" } } }

      it "returns a 401 status code" do
        post api_v1_verticals_path, params: invalid_attributes
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
