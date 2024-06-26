# frozen_string_literal: true

class DescriptionInterpreter
  # Data on most common prepositions in dataset gathered with scripts from scripts directory
  COMMON_PREPOSITIONS = %w[
    of
    in
    for
    as
  ].freeze

  attr_reader :description, :product_name, :amount, :unit

  def initialize(description)
    @description = description
  end

  def call
    {
      name: product_name,
      unit:,
      amount:
    }.compact
  end

  def with_all
    with_unit
      .with_amount
      .with_product_name
  end

  def with_unit
    @unit ||= description.split.detect do |word|
      Unit.unit_words.include?(word)
    end || ''
    self
  end

  def with_amount
    amount_words = description.split.select do |word|
      word =~ /[0-9½⅓¼⅕¾⅒.,]+/
    end

    @amount ||= amount_words.map { |word| amount_word_to_f(word) }.sum
    self
  end

  def with_product_name
    description_without_instructions = description.split(',').first
    @product_name ||= description_without_instructions.split.select do |word|
      word =~ /[a-zA-Z]+/ && COMMON_PREPOSITIONS.exclude?(word) && Unit.unit_words.exclude?(word)
    end.join(' ').singularize
    self
  end

  private

  def amount_word_to_f(word)
    return Unit::FRACTION_MAP[word] if word =~ /[½⅓¼⅕¾⅒]{1}/

    word.to_f
  end
end
