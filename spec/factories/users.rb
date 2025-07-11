# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    age { Faker::Number.between(from: 18, to: 99) }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::Number.unique.number(digits: 10).to_s }
  end
end