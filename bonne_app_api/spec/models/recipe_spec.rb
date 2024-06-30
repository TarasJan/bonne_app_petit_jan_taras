# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject(:recipe) { build(:recipe) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:author) }
    it { is_expected.to validate_presence_of(:prep_time) }
    it { is_expected.to validate_presence_of(:cook_time) }
    it { is_expected.to validate_presence_of(:author) }

    it { is_expected.to validate_numericality_of(:prep_time).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:cook_time).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_numericality_of(:ratings).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5) }
  end

  describe 'scopes' do
    describe 'cold' do
      subject(:cold_recipes) do
        described_class.cold
      end

      before do
        create(:recipe, cook_time: 15)
        create(:recipe, title: 'Ice Cream', cook_time: 0)
        create(:recipe, cook_time: 30)
      end

      it 'returns only dishes that need no cooking' do
        expect(cold_recipes.size).to eq(1)
        expect(cold_recipes.first.title).to eq('Ice Cream')
      end
    end

    describe 'with_ratings_better_or_equal_to' do
      subject(:four_plus_stars_recipes) do
        described_class.with_ratings_better_or_equal_to(4)
      end

      before do
        create(:recipe, ratings: 5)
        create(:recipe, ratings: 4)
        create(:recipe, ratings: 2)
      end

      it 'returns only recipes with rating greater or equal to stated' do
        expect(four_plus_stars_recipes.size).to eq(2)
        expect(four_plus_stars_recipes).to(be_all { |r| r.ratings >= 4 })
      end
    end
  end
end
