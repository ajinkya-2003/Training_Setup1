# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Load the database builder from lib/build
require Rails.root.join('lib', 'build', 'database_builder')

# Run the database builder to seed the database
Build::DatabaseBuilder.run
#   end
