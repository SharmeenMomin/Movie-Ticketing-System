# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
admin_email = 'admin517@gmail.com'
admin_password = 'adminpassword517' # Make sure this is a strong password, or ask the admin to change it later

# Check if the admin already exists to avoid duplicate records
if Admin.find_by(email: admin_email).nil?
  Admin.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password # Ensure the password is confirmed
  )
  puts "Admin account created with email: #{admin_email}"
else
  puts "Admin account already exists with email: #{admin_email}"
end
