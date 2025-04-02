class ChangeDurationToStringsInMovies < ActiveRecord::Migration[8.0]
  def change
    change_column :movies, :duration, :string
  end
end
