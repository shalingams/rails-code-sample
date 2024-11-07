# spec/factories/courses.rb
FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" } # Ensures unique course names
    author { "Author #{rand(1..100)}" } # Generates a random author name
    state { "active" }
    association :category # Associates the course with a category
  end
end
