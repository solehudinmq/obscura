# Obscura

Obscura is a Ruby library for masking column values ​​in tables, which can be set via a model, and is temporary. Therefore, when you need to mask sensitive data, this library is ideal.

With the Obscura library, your Ruby application can temporarily manipulate the values ​​of columns in the model. This allows us to mask private column values ​​to maintain their confidentiality.

## High Flow

Potential privacy issues when data should not be visible to everyone :

![Logo Ruby](https://github.com/solehudinmq/obscura/blob/development/high_flow/Obscura-problem.jpg)

With Obscura, we can now manipulate values ​​to mask them, so that sensitive data cannot be seen by everyone :

![Logo Ruby](https://github.com/solehudinmq/obscura/blob/development/high_flow/Obscura-solution.jpg)

## Requirement

The minimum version of Ruby that must be installed is 3.0.

Requires dependencies to the following gems :
- activerecord

- activesupport

## Installation

Add this line to your application's Gemfile :

```ruby
# Gemfile
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

For more details, you can see the following example : [example/user.rb](Here).

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

For more details, you can see the following example : [example/app.rb](Here).

## Example Implementation in Your Application

For examples of applications that use this gem, you can see them here : [example](Here).

## Example of Response That has been Censored

For examples of applications that use this gem, you can see them here : [example/response.json](Here).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solehudinmq/obscura.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
