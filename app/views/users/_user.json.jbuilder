json.extract! user, :id, :username, :name, :email, :password, :phone_number, :address, :credit_card, :created_at, :updated_at
json.url user_url(user, format: :json)
