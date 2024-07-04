# frozen_string_literal: true

require 'spec_helper'

describe 'RareIngredientSearch Scenario 04'  do
  let(:driver) do
    Selenium::WebDriver.for :chrome
  end

  let(:wait) do
    Selenium::WebDriver::Wait.new(timeout: 30)
  end

  # Given "I have a rare ingredient - kefir at home"
  let(:ingredient_names) do
    ["kefir"]
  end
  
  it "fulfills the scenario" do
     # When "I go to Bonne App Petit, search kefir in the multiselect"
    driver.navigate.to ENV["BONNE_APP_HOST"]

    dropdown_arrow = driver.find_element(:class, 'p-multiselect')
    wait.until { dropdown_arrow.displayed? }
    sleep(5)
    dropdown_arrow.click
    sleep(5)

    search_input = driver.find_element(:class, 'p-multiselect-filter')
    search_input.send_keys(ingredient_names.first)

    ingredient_names.each do |ingredient|
      element = driver.find_element(:xpath, "//*[text()='#{ingredient}']", )
      wait.until { element.displayed? }
      sleep(2)
      element.click
    end

    # Then "Recipe containing the ingredients are displayed"
    
    cards = driver.find_elements(:class, 'p-card')
    expect(cards.size).to eq(1)

    driver.quit
  end
  
end