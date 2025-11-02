# app.rb
require 'sinatra'
require 'json'
require 'byebug'
require_relative 'user'

# Route to retrieve user data
get '/users' do
  begin
    limit = (params[:limit] || 10).to_i
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