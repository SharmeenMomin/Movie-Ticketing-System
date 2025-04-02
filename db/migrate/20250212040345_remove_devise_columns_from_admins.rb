class RemoveDeviseColumnsFromAdmins < ActiveRecord::Migration[6.0]
  def change
    remove_column :admins, :encrypted_password if column_exists?(:admins, :encrypted_password)
    remove_column :admins, :reset_password_token if column_exists?(:admins, :reset_password_token)
    # Add other columns as needed
  end
end
