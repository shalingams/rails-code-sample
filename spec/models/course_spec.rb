# spec/models/course_spec.rb
require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create(:course) }

  it "is valid with valid attributes" do
    expect(course).to be_valid
  end

  it "is not valid without a name" do
    course.name = nil
    expect(course).not_to be_valid
  end

  it "is not valid without an author" do
    course.author = nil
    expect(course).not_to be_valid
  end

  it "is not valid without a category" do
    course.category = nil
    expect(course).not_to be_valid
  end
end
