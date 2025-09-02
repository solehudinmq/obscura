require 'sinatra'
require 'active_record'
require 'obscura'

# Configure database connections
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

# Create a db directory if it doesn't exist yet
Dir.mkdir('db') unless File.directory?('db')

class User < ActiveRecord::Base
  include Obscura

  mask_attributes :email, :phone_number
end

# Migration to create users table
ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.table_exists?(:users)
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.timestamps
    end
  end
end