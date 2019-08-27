# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    subject { User.new(first_name: 'Lab', last_name: 'Rat', email: 'labrat@test.com', password: '12345678', password_confirmation: '12345678') }
    it 'is valid when it has valid inputs' do
      expect(subject).to be_valid
    end

    it 'is not valid when first name is not present' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid when last name is not present' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid when email is not present' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid when password != password_confirmation' do
      subject.password = 'x'
      expect(subject).to_not be_valid
    end

    it 'is not valid when the email exists in the database' do
      subject.save
      @original_email = User.new(first_name: 'Brian', last_name: 'Chang', email: 'labrat@test.com', password: '12345678', password_confirmation: '12345678')
      expect(@original_email).to_not be_valid
      @original_email_with_one_uppercase = User.new(first_name: 'John', last_name: 'Hancock', email: 'labRat@test.com', password: '12345678', password_confirmation: '12345678')
      expect(@original_email_with_one_uppercase).to_not be_valid
    end

    it 'is not valid when the password is less than 8 characters long' do
      subject.password = 'abc'
      subject.password_confirmation = 'abc'
      expect(subject).to_not be_valid
    end
  end

  context '.authenticate_with_credentials' do
    before { User.create(first_name: 'Lab', last_name: 'Rat', email: 'labrat@test.com', password: 'abcdabcd', password_confirmation: 'abcdabcd') }

    it 'should not authenticate when email doesn\'t exist' do
      params = { email: 'hola@test.com', password: 'abcdabcd' }
      user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(user).to be_nil
    end
    it 'should not authenticate when password is wrong' do
      params = { email: 'labrat@test.com', password: '12345678' }
      user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(user).to be_nil
    end
    it 'should authenticate with spaces around the email' do
      params1 = { email: '  labrat@test.com', password: 'abcdabcd' }
      params2 = { email: ' labrat@test.com ', password: 'abcdabcd' }
      params3 = { email: 'labrat@test.com  ', password: 'abcdabcd' }

      user = User.find_by(email: "labrat@test.com")

      user1 = User.authenticate_with_credentials(params1[:email], params1[:password])
      user2 = User.authenticate_with_credentials(params2[:email], params2[:password])
      user3 = User.authenticate_with_credentials(params3[:email], params3[:password])

      expect(user1).to eq user
      expect(user2).to eq user
      expect(user3).to eq user
    end

    it 'should authenticate with incorrect cases' do
      params = { email: 'Labrat@test.com', password: 'abcdabcd' }
      user = User.find_by(email: "labrat@test.com")

      test_user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(test_user).to eq user
    end
  end
end
