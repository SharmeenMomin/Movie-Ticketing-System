class AddConstraintsToShows < ActiveRecord::Migration[8.0]
  def change
    change_column :shows, :available_seats, :integer, null: false, default: 0
    change_column :shows, :ticket_price, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
