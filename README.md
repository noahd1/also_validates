# ValidationAggregator

An ActiveModel validator that validates associated models, adding any errors on those models back onto the "primary" model.

## Installation

Add this line to your application's Gemfile:

    gem 'validation_aggregator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validation_aggregator

## Usage

    class Beer
      include ActiveModel::Validations

      validate_presence_of :hops
    end

    class Belly
      include ActiveModel::Validations

      validate_presence_of :button
    end

    class MonsterTruckRally
      include ActiveModel::Validations

      attr_accessor :beer, :belly

      validate_presence_of :truck_count
      also_validate :beer, :belly

      def initialize(beer, belly)
        @beer  = beer
        @belly  = belly
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
