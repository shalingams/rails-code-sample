# spec/requests/courses_spec.rb
require 'rails_helper'

RSpec.describe "Courses API", type: :request do
  let(:vertical) { create(:vertical) }
  let(:category) { create(:category, vertical: vertical) }
  let(:access_token) { create(:access_token) }

  describe "GET /api/v1/verticals/:vertical_id/categories/:category_id/courses" do
    before do
      create_list(:course, 3, category: category)
    end

    it "returns all courses for a given category" do
      get api_v1_vertical_category_courses_path(vertical_id: vertical.id, category_id: category.id), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /api/v1/verticals/:vertical_id/categories/:category_id/courses" do
    let(:valid_attributes) { { course: { name: "New Course", author: "Test Author", state: "active" } } }

    it "creates a new course" do
      expect {
        post api_v1_vertical_category_courses_path(vertical_id: vertical.id, category_id: category.id), params: valid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
      }.to change(Course, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns a validation error when name is missing" do
      invalid_attributes = { course: { name: nil, author: "Test Author", state: "active" } }
      post api_v1_vertical_category_courses_path(vertical_id: vertical.id, category_id: category.id), params: invalid_attributes, headers: { Authorization: "Bearer #{access_token.token}" }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /api/v1/verticals/:vertical_id/categories/:category_id/courses/:id" do
    let(:course) { create(:course, category: category) }
    let(:updated_attributes) { { course: { name: "Updated Course Name" } } }

    it "updates an existing course" do
      put api_v1_vertical_category_course_path(vertical_id: vertical.id, category_id: category.id, id: course.id), params: updated_attributes, headers: { Authorization: "Bearer #{access_token.token}" }
      course.reload
      expect(response).to have_http_status(:ok)
      expect(course.name).to eq("Updated Course Name")
    end
  end

  describe "DELETE /api/v1/verticals/:vertical_id/categories/:category_id/courses/:id" do
    let!(:course) { create(:course, category: category) }

    it "deletes an existing course" do
      expect {
        delete api_v1_vertical_category_course_path(vertical_id: vertical.id, category_id: category.id, id: course.id), headers: { Authorization: "Bearer #{access_token.token}" }
      }.to change(Course, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
