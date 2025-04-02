FactoryBot.define do
  factory :movie do
    title { "Inception" }
    genre { "Sci-Fi" }
    duration { 120 }
    language { "English" }
    rating { "PG-13" }
    release_date { "2025-06-15" }
  end
end
