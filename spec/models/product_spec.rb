# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject { Product.new(name: 'Cup', price: 200, quantity: 23, category: Category.new(name: 'Test')) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
      expect(subject.errors.full_messages[0]).to be_nil
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages[0]).to eq 'Name can\'t be blank'
    end

    it 'is not valid without a price' do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages[0]).to eq 'Price cents is not a number'
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages[0]).to eq 'Quantity can\'t be blank'
    end

    it 'is not valid without a category' do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages[0]).to eq 'Category can\'t be blank'
    end
  end
end
