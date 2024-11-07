# spec/factories/verticals.rb
FactoryBot.define do
  factory :vertical do
    sequence(:name) { |n| "Vertical #{n}" } # Generates unique names like "Vertical 1", "Vertical 2"
  end
end
