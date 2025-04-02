FactoryBot.define do
  factory :user do
    username { "TestUser" }
    name { "TestUser" }
    email { "test@example.com" }
    password { "password123" }
    phone_number { "1234567890" }
    address { "NC" }
    credit_card { "2222-2222-3333" }
    is_admin { false }

    trait :admin do
      username { "Admin" }
      name { "Admin" }
      email { "admin@example.com" }
      password { "Admin123" }
      phone_number { "1234567888" }
      address { "NC" }
      credit_card { "2222-2222-3333" }
      is_admin { true }
    end
  end
end
