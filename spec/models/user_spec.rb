# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  # Test valid user creation (with Devise handling email/password)
  it "is valid with valid attributes" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # Test first_name presence validation
  it "is not valid without a first_name" do
    user = FactoryBot.build(:user, first_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # Test first_name length validation
  it "is not valid with a first_name shorter than 2 characters" do
    user = FactoryBot.build(:user, first_name: "A")
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("is too short (minimum is 2 characters)")
  end

  # Test last_name presence validation
  it "is not valid without a last_name" do
    user = FactoryBot.build(:user, last_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # Test last_name length validation
  it "is not valid with a last_name shorter than 2 characters" do
    user = FactoryBot.build(:user, last_name: "B")
    expect(user).to_not be_valid
    expect(user.errors[:last_name]).to include("is too short (minimum is 2 characters)")
  end

  # Test age presence validation
  it "is not valid without an age" do
    user = FactoryBot.build(:user, age: nil)
    expect(user).to_not be_valid
    expect(user.errors[:age]).to include("can't be blank")
  end

  # Test age numericality validation (greater than or equal to 18)
  it "is not valid with an age less than 18" do
    user = FactoryBot.build(:user, age: 17)
    expect(user).to_not be_valid
    expect(user.errors[:age]).to include("must be greater than or equal to 18")
  end

  # Test age numericality validation (less than 100)
  it "is not valid with an age 100 or greater" do
    user = FactoryBot.build(:user, age: 100)
    expect(user).to_not be_valid
    expect(user.errors[:age]).to include("must be less than 100")
  end

  # Test date_of_birth presence validation
  it "is not valid without a date_of_birth" do
    user = FactoryBot.build(:user, date_of_birth: nil)
    expect(user).to_not be_valid
    expect(user.errors[:date_of_birth]).to include("can't be blank")
  end

  # Test phone presence validation
  it "is not valid without a phone number" do
    user = FactoryBot.build(:user, phone: nil)
    expect(user).to_not be_valid
    expect(user.errors[:phone]).to include("can't be blank")
  end

  # Test phone format validation
  it "is not valid with an invalid phone number format" do
    user = FactoryBot.build(:user, phone: "123")
    expect(user).to_not be_valid
    expect(user.errors[:phone]).to include("must be a 10-digit number")

    user = FactoryBot.build(:user, phone: "abcdefghij")
    expect(user).to_not be_valid
    expect(user.errors[:phone]).to include("must be a 10-digit number")
  end

  # Test adult? method
  describe "#adult?" do
    it "returns true if the user is 18 or older" do
      user = FactoryBot.build(:user, date_of_birth: 20.years.ago.to_date)
      expect(user.adult?).to be true
    end

    it "returns false if the user is younger than 18" do
      user = FactoryBot.build(:user, date_of_birth: 10.years.ago.to_date)
      expect(user.adult?).to be false
    end

    it "returns false if date_of_birth is nil" do
      user = FactoryBot.build(:user, date_of_birth: nil)
      expect(user.adult?).to be false
    end
  end
end
