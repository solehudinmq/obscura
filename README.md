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

class User < ActiveRecord::Base
  include Obscura

  mask_attributes :email, :phone_number
end
```

How to use masking :
```ruby
user = User.first
user.email # test1@test.com (normal value)
user.masked_email # ************** (full masking)
user.half_masked_phone_number # +6211***** (half masking)
```

Understanding each masking method :
- masked_{column_name} = value will be masked in full, example : **************.
- half_masked_{column_name} = value will be masked half full, example : +6211*****.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solehudinmq/obscura.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
