# frozen_string_literal: true

require 'active_support/concern'

require_relative "obscura/version"

module Obscura extend ActiveSupport::Concern
  class Error < StandardError; end
  # Your code goes here...
  
  module ClassMethods
    def mask_attributes(*attributes)
      attributes.each do |attribute|
        # masking all values
        define_method "masked_#{attribute}" do
          value = send(attribute)

          # Replace with masking character
          value.to_s.gsub(/./, '*')
        end

        # masking some of the values ​​at the end
        define_method "half_masked_#{attribute}" do
          value = send(attribute)

          length = value.length
          half = length / 2
          
          # Take the string after the midpoint
          masked_part = value[half..-1]

          # Replace with masking character
          value.sub(masked_part, '*' * masked_part.length)
        end
      end
    end
  end
end
