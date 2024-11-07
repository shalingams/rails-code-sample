# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it "is valid with valid attributes" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = nil
    expect(category).not_to be_valid
  end

  it "is not valid without a vertical" do
    category.vertical = nil
    expect(category).not_to be_valid
  end
end
