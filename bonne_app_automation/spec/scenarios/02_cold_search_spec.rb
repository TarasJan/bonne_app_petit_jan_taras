# frozen_string_literal: true

require 'spec_helper'

describe "ColdSearch User Scenario 2" do
  let(:driver) do
    Selenium::WebDriver.for :chrome
  end

  let(:wait) do
    Selenium::WebDriver::Wait.new(timeout: 30)
  end

  # Given "I am a person camping, I do cannot cook / start fire in the national park, I have honey and egg"
  let(:ingredient_names) do
    ["egg", "honey"]
  end
  
  it "fulfills the scenario" do
     #   When "I go to Bonne App Petit, select honey and egg from the multiselect"
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

    #   And "I select checkbox to show only cold dishes"
    dropdown_arrow.click
    sleep(2)
    driver.find_element(:id, 'no_time').click

    sleep(5)
    # Then "Recipes containing the ingredients are displayed"
    
    cards = driver.find_elements(:class, 'p-card')
    expect(cards.size).to eq(20)

    #   And "Only ingredients that require no cooking are shown - I can see this in `No cooking needed` badge"
    expect(
      cards.all? do |card|
      tags = card.find_elements(:class, 'p-chip-text')
      tags.any? do |tag|
        tag.text == 'No cooking needed!'
      end
    end
    ).to be_truthy

    driver.quit
  end
end