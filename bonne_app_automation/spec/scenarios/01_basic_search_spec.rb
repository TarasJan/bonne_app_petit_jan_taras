# frozen_string_literal: true

require 'spec_helper'

describe "BasicSearch User Scenario 1" do
  let(:driver) do
    Selenium::WebDriver.for :chrome
  end

  let(:wait) do
    Selenium::WebDriver::Wait.new(timeout: 30)
  end

  # GIVEN "I am a person working from home, I have eggs, sugar and bananas in the kitchen"
  let(:ingredient_names) do
    ["egg", "sugar", "banana"]
  end
  
  it "fulfills the scenario" do
    # When "I go to Bonne App Petit, select eggs sugar and bananas from the multiselect"
    driver.navigate.to ENV["BONNE_APP_HOST"]

    dropdown_arrow = driver.find_element(:class, 'p-multiselect')
    wait.until { dropdown_arrow.displayed? }
    sleep(5)
    dropdown_arrow.click
    sleep(5)

    ingredient_names.each do |ingredient|
      element = driver.find_element(:xpath, "//*[text()='#{ingredient}']", )
      wait.until { element.displayed? }
      sleep(2)
      element.click
    end

    # Then "Recipes containing the ingredients are displayed"
    sleep(5)
    
    cards = driver.find_elements(:class, 'p-card')
    expect(cards.size).to eq(20)

    # And "The order of recipes follows how many of the ingredients they use from the ones using most of my ingredients - I can see it on the Match score"
    expect(
      cards.all? do |card|
      tags = card.find_elements(:class, 'p-chip-text')
      tags.any? do |tag|
        tag.text =~ /Match [0-9]+\.[0-9]+ \%/
      end
    end
    ).to be_truthy

    driver.quit
  end
end
