# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user_email = email.strip
    puts user_email.downcase
    user = User.find_by("LOWER(email) = ?", user_email.downcase)
    if user&.authenticate(password)
      return user
    else
      return nil
    end
  end
end
