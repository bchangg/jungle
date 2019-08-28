# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor navigates to a specific product', type: :feature do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    @product = @category.products.create!(
      name: Faker::Hipster.sentence(word_count: 2),
      description: Faker::Hipster.paragraph(sentence_count: 3),
      image: open_asset('apparel1.jpg'),
      price: 9.99,
      quantity: 15
    )
  end

  scenario 'They see the product\'s details' do
    # ACT
    visit product_path(@product)

    expect(page).to have_css 'article.product-detail'
  end
end
