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
end
