# frozen_string_literal: true

require 'spec_helper'

describe 'MinimalRatingSearch Scenario 03'  do
  let(:driver) do
    Selenium::WebDriver.for :chrome
  end

  let(:wait) do
    Selenium::WebDriver::Wait.new(timeout: 30)
  end

  # Given "I am a picky eater, I need only good recipes, I have milk, butter, and sugar in my pantry"
  let(:ingredient_names) do
    ["milk", "butter", "sugar"]
  end
  
  it "fulfills the scenario" do
     # When "I go to Bonne App Petit, select milk, butter, and sugar from the multiselect"
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

    # And "I select four stars on the minimal rating"
    dropdown_arrow.click
    sleep(2)
    rating = driver.find_element(:class, 'p-rating')
    rating.find_elements(:class, 'p-rating-item')[3].click


    sleep(5)
    # Then "Recipes containing the ingredients are displayed"
    
    cards = driver.find_elements(:class, 'p-card')
    expect(cards.size).to eq(20)

    # And "Only recipes with 4 or more star rating are shown"
    active_stars = driver.find_elements(:class, 'p-rating-item-active')

    expect(
      active_stars.size >= 84
    ).to be_truthy

    driver.quit
  end
  
end