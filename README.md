# Obscura

Obscura is a Ruby library for masking column values ​​in tables, which can be set via a model, and is temporary. Therefore, when you need to mask sensitive data, this library is ideal.

With the Obscura library, your Ruby application can temporarily manipulate the values ​​of columns in the model. This allows us to mask private column values ​​to maintain their confidentiality.

## High Flow

Potential privacy issues when data should not be visible to everyone :
![Logo Ruby](https://github.com/solehudinmq/obscura/blob/development/high_flow/Obscura-problem.jpg)

With Obscura, we can now manipulate values ​​to mask them, so that sensitive data cannot be seen by everyone :
![Logo Ruby](https://github.com/solehudinmq/obscura/blob/development/high_flow/Obscura-solution.jpg)


## Installation

The minimum version of Ruby that must be installed is 3.0.
Only runs on activerecord.

Add this line to your application's Gemfile :

```ruby
gem 'obscura', git: 'git@github.com:solehudinmq/obscura.git', branch: 'main'
```

Open terminal, and run this : 
```bash
cd your_ruby_application
bundle install
```

## Usage

In the model that will implement masking add this :
```ruby
require 'obscura'

class YourModel < ActiveRecord::Base
  include Obscura

  mask_attributes :column1, :column2 # can be more than 1 column
end
```

How to use masking :
```ruby
data = YourModel.first
data.column1 # +621122233 (normal value)
data.masked_column1 # ********** (full masking)
data.half_masked_column1 # +6211***** (half masking)
```

Understanding each masking method :
- masked_{column_name} = value will be masked in full, example : **************.
- half_masked_{column_name} = value will be masked half full, example : +6211*****.

The following is an example of its use in your application :
```ruby
# Gemfile

# frozen_string_literal: true

source "https://rubygems.org"

gem "sqlite3"
gem "sinatra"
gem "activerecord"
gem "byebug"
gem 'obscura', git: 'git@github.com:solehudinmq/obscura.git', branch: 'main'
gem "rackup", "~> 2.2"
gem "puma", "~> 6.6"
```

```ruby
# user.rb
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
```

```ruby
# app.rb
require 'sinatra'
require 'json'
require 'byebug'
require_relative 'user'

# Route to retrieve user data
get '/users' do
  begin
    limit = params[:limit].to_i || 10
    users = []
    User.all.limit(limit).each do |user|
      users << {
        id: user.id,
        name: user.name,
        email: user.masked_email,
        phone_number: user.half_masked_phone_number
      }
    end

    content_type :json
    { data: users, meta: { limit: limit } }.to_json
  rescue => e
    content_type :json
    status 500
    return { error: e.message }.to_json
  end
end

# Route to enter dummy data
post '/seed' do
  # Delete old data and enter new data
  User.destroy_all
  15.times do |i|
    User.create(name: "User #{15-i}", email: "email#{15-i}@test.com", phone_number: "+62111111#{i-i}")
    sleep(0.1) # Add a gap to make the created_at different
  end
  'Database seeded dengan 15 users.'
end

# open terminal
# cd your_project
# bundle install
# bundle exec ruby app.rb
# curl --location --request POST 'http://localhost:4567/seed' // untuk create dummy data
# curl --location 'http://localhost:4567/users?limit=5'
```

Example of api response :
```json
{
    "data": [
        {
            "id": 1,
            "name": "User 15",
            "email": "****************",
            "phone_number": "+6211*****"
        },
        {
            "id": 2,
            "name": "User 14",
            "email": "****************",
            "phone_number": "+6211*****"
        },
        {
            "id": 3,
            "name": "User 13",
            "email": "****************",
            "phone_number": "+6211*****"
        },
        {
            "id": 4,
            "name": "User 12",
            "email": "****************",
            "phone_number": "+6211*****"
        },
        {
            "id": 5,
            "name": "User 11",
            "email": "****************",
            "phone_number": "+6211*****"
        }
    ],
    "meta": {
        "limit": 5
    }
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solehudinmq/obscura.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
