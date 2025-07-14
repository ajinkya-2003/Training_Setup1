# frozen_string_literal: true

require Rails.root.join('lib', 'build', 'database_builder')

Build::DatabaseBuilder.run

