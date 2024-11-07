# db/seeds.rb

# Clear existing data
Course.delete_all
Category.delete_all
Vertical.delete_all

# Create Verticals
vertical_health = Vertical.create!(name: "Health & Fitness")
vertical_business = Vertical.create!(name: "Business")
vertical_music = Vertical.create!(name: "Music")
puts "Seeding completed for Verticals!"

# Create Categories for each Vertical
category_1 = Category.create!(name: "Booty & Abs", vertical: vertical_health, state: "active")
category_2 = Category.create!(name: "Full Body", vertical: vertical_health, state: "active")
category_3 = Category.create!(name: "Advertising", vertical: vertical_business, state: "active")
category_4 = Category.create!(name: "Writing", vertical: vertical_business, state: "active")
category_5 = Category.create!(name: "Singing", vertical: vertical_music, state: "active")
category_6 = Category.create!(name: "Music Fundamentals", vertical: vertical_music, state: "active")
puts "Seeding completed for Categories!"

# Create Courses for each Category
Course.create!(name: "Loose the Gutt, keep the Butt", author: "Anowa", category: category_1, state: "active")
Course.create!(name: "BrittneBabe Fitness Transformation", author: "Brittnebabe", category: category_1, state: "active")
Course.create!(name: "BTX: Body Transformation Extreme", author: "Barstarzz", category: category_2, state: "active")
Course.create!(name: "Facebook Funnel Marketing", author: "Russell Brunson", category: category_3, state: "active")
Course.create!(name: "Build a Wild Audience", author: "Tim Nilson", category: category_3, state: "active")
Course.create!(name: "Editorial Writing Secrets", author: "J. K. Rowling", category: category_4, state: "active")
Course.create!(name: "Scientific Writing", author: "Stephen Hawking", category: category_4, state: "active")
Course.create!(name: "Vocal Training 101", author: "Linkin Park", category: category_5, state: "active")
Course.create!(name: "Music Production", author: "Lady Gaga", category: category_5, state: "active")
Course.create!(name: "Learn the Piano", author: "Lang Lang", category: category_6, state: "active")
Course.create!(name: "Become a guitar hero", author: "Jimmy Page", category: category_6, state: "active")

puts "Seeding completed!"
