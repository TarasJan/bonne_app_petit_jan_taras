# frozen_string_literal: true

module Unit
  FRACTION_MAP = {
    '½' => 0.5,
    '⅓' => 1.0 / 3,
    '¼' => 0.25,
    '¾' => 0.75,
    '⅒' => 0.1
  }.freeze

  AVAILABLE_UNITS = %w[
    pound
    cup
    teaspoon
    tablespoon
    package
    pinch
    piece
    can
  ].freeze

  def self.unit_words
    [*AVAILABLE_UNITS, *AVAILABLE_UNITS.map(&:pluralize)]
  end
end
