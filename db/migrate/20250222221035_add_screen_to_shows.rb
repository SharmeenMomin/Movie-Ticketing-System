class AddScreenToShows < ActiveRecord::Migration[8.0]
  def change
    add_reference :shows, :screen, foreign_key: true, null: true # Allow null values first

    # Optional: If you want to set a default screen for existing shows:
    default_screen = Screen.first || Screen.create!(name: "Default Screen", location: "Unknown", capacity: 100)
    Show.update_all(screen_id: default_screen.id)

    # Now enforce NOT NULL constraint
    change_column_null :shows, :screen_id, false  end
end
