# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor adds an item to the cart', type: :feature, js: true do
  before :each do
    @category = Category.create(name: 'food')
    10.times do
      @category.products.create!(
        name: Faker::Hipster.sentence(word_count: 3),
        description: Faker::Hipster.paragraph(sentence_count: 4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They should see cart number increase when they click on different products' do
    visit root_path

    within all("article")[0] do
      find_button("Add").click
    end

    within all("article")[1] do
      find_button("Add").click
    end

    expect(page).to have_content("My Cart (2)")
  end
end
