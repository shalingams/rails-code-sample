# spec/requests/categories_spec.rb
require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  let(:vertical) { create(:vertical) }
  let(:access_token) { create(:access_token) }

  describe "GET /api/v1/verticals/:vertical_id/categories" do
    before do
      create_list(:category, 3, vertical: vertical)
    end

    it "returns all categories for a given vertical" do
      get api_v1_vertical_categories_path(vertical_id: vertical.id), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /api/v1/verticals/:vertical_id/categories" do
    let(:valid_attributes) { { category: { name: "New Category", state: "active" } } }

    it "creates a new category" do
      expect {
        post api_v1_vertical_categories_path(vertical_id: vertical.id), params: valid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
      }.to change(Category, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns a validation error when name is missing" do
      invalid_attributes = { category: { name: nil, state: "active" } }
      post api_v1_vertical_categories_path(vertical_id: vertical.id), params: invalid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /api/v1/verticals/:vertical_id/categories/:id" do
    let(:category) { create(:category, vertical: vertical) }
    let(:updated_attributes) { { category: { name: "Updated Name" } } }

    it "updates an existing category" do
      put api_v1_vertical_category_path(vertical_id: vertical.id, id: category.id), params: updated_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
      category.reload
      expect(response).to have_http_status(:ok)
      expect(category.name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/verticals/:vertical_id/categories/:id" do
    let!(:category) { create(:category, vertical: vertical) }

    it "deletes an existing category" do
      expect {
        delete api_v1_vertical_category_path(vertical_id: vertical.id, id: category.id), headers: { Authorization: "Bearer #{access_token.token}" }
      }.to change(Category, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
