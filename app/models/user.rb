# app/models/user.rb

# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom validations
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  # Devise's :validatable module already handles email presence, uniqueness, and format.
  # Devise's :validatable module already handles password presence and length.
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18, less_than: 100 }
  validates :date_of_birth, presence: true
  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }

  # Add a method to check if the user is an adult based on date_of_birth
  def adult?
    date_of_birth.present? && date_of_birth <= 18.years.ago.to_date
  end
end
