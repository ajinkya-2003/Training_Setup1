# frozen_string_literal: true

require 'faker'

module Build
  class DatabaseBuilder
    def reset_data
      # Clean all records from the database
      puts 'Cleaning database...'
      User.destroy_all
      puts 'Database cleaned successfully!'
    end

    def create_users
      puts 'Creating users...'
      10.times do
        # Generate a date of birth for a person who is between 18 and 80 years old
        dob = Faker::Date.birthday(min_age: 18, max_age: 80)
        # Calculate the age based on the date of birth
        age = ((Date.today - dob) / 365.25).floor

        User.create!(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.unique.email,
          age: age,
          date_of_birth: dob,
          phone: Faker::Number.number(digits: 10),
          password: 'password123',
          password_confirmation: 'password123'
        )
      end
      puts "Created #{User.count} users successfully!"
    end

    def execute
      # Execute seeding methods in order
      reset_data
      create_users
    end

    def self.run
      new.execute
    end
  end
end
