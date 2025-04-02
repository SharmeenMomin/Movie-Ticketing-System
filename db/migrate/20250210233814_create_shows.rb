class CreateShows < ActiveRecord::Migration[8.0]
  def change
    create_table :shows do |t|
      t.references :movie, null: false, foreign_key: true
      t.date :date
      t.time :time
      t.integer :seats_available
      t.decimal :ticket_price

      t.timestamps
    end
  end
end
