# spec/models/vertical_spec.rb
require 'rails_helper'

RSpec.describe Vertical, type: :model do
  let(:vertical) { create(:vertical) }

  it "is valid with valid attributes" do
    expect(vertical).to be_valid
  end

  it "is not valid without a name" do
    vertical.name = nil
    expect(vertical).not_to be_valid
  end

  it "validates uniqueness of name" do
    create(:vertical, name: "Unique Vertical")
    duplicate_vertical = build(:vertical, name: "Unique Vertical")
    expect(duplicate_vertical).not_to be_valid
  end

  it "can have many categories" do
    category1 = create(:category, vertical: vertical)
    category2 = create(:category, vertical: vertical)
    expect(vertical.categories).to include(category1, category2)
  end

  it "validates uniqueness of name cross models" do
    create(:category, name: "Unique Vertical")
    vertical = build(:vertical, name: "Unique Vertical")
    expect(vertical).not_to be_valid
  end
end
