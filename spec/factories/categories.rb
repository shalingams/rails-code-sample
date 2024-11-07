# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" } # Ensures unique category names
    state { "active" }
    association :vertical # Associates the category with a vertical
  end
end
