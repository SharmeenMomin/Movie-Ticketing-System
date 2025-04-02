json.extract! show, :id, :movie_id, :date, :time, :seats_available, :ticket_price, :created_at, :updated_at
json.url show_url(show, format: :json)
