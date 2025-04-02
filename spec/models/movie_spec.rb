require 'rails_helper'

RSpec.describe Movie, type: :model do
  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:release_date) }

  # Associations
  it { should have_many(:shows).dependent(:destroy) }

  # Instance Methods
  describe '#released?' do
    let(:future_movie) { create(:movie, release_date: 1.day.from_now) }
    let(:past_movie) { create(:movie, release_date: 1.day.ago) }

    it 'returns false for a movie released in the future' do
      expect(future_movie.released?).to eq(false)
    end

    it 'returns true for a movie released in the past' do
      expect(past_movie.released?).to eq(true)
    end

    it 'returns true for a movie released today' do
      today_movie = create(:movie, release_date: Date.today)
      expect(today_movie.released?).to eq(true)
    end
  end
end
