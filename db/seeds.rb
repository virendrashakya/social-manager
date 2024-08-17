# db/seeds.rb

# Clear existing plans (optional)
Plan.destroy_all

# Create plans with predefined names and attributes
Plan.create([
  { name: 'Free', price: 0.0, duration: 0 },
  { name: 'Basic', price: 9.99, duration: 30 },   # duration in days
  { name: 'Premium', price: 19.99, duration: 30 }, # duration in days
  { name: 'Enterprise', price: 49.99, duration: 30 } # duration in days
])

puts "Plans have been seeded."