class CreateAdmin < ActiveRecord::Migration[8.0]
  def change
    # Ensure is_admin defaults to false
    change_column_default :users, :is_admin, true

    # Create an admin user if one does not already exist
    User.create!(
      username: "Admin",
      name: "Admin User",
      email: "admin@example.com",
      password: "SecurePass123",
      password_confirmation: "SecurePass123",
      is_admin: true,
      phone_number: "1234",
      address: "1234",
      credit_card: "1234"
    ) unless User.exists?(email: "admin@example.com")
  end

  def down
    # Remove the predefined admin user if it exists
    User.find_by(email: "admin@example.com")&.destroy
  end
end
