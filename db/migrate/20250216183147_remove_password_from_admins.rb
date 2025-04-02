class RemovePasswordFromAdmins < ActiveRecord::Migration[8.0]
  def change
    remove_column :admins, :password, :string
  end
end
