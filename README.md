[![Code Climate](https://codeclimate.com/github/noahd1/also_validates.png)](https://codeclimate.com/github/noahd1/also_validates)

# AlsoValidates

An ActiveModel validator that validates associated models, copying any errors from composed models up to their parent.

## Installation

Add this line to your application's Gemfile:

    gem 'also_validates'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install also_validates

## Usage

Given existing models with their own validations:

    class Beer
      include ActiveModel::Validations
      attr_accessor :hops
      validates_presence_of :hops

      def initialize(attrs = {})
        @hops = attrs[:hops]
      end
    end

    class Belly
      include ActiveModel::Validations
      attr_accessor :button
      validates_presence_of :button

      def initialize(attrs = {})
        @button = attrs[:button]
      end
    end

And you need a model that composes those models:

    class MonsterTruckRally
      include ActiveModel::Validations

      attr_accessor :beer, :belly, :truck_count

      validates_presence_of :truck_count
      also_validates :beer, :belly

      def initialize(attrs = {})
        @beer = attrs[:beer]
        @belly = attrs[:belly]
        @truck_count = attrs[:truck_count]
      end
    end

Calling `valid?` on an instance of monster truck rally, will run validations on both the monster truck rally as well as any models specified by `also_validates`. If there are any validation errors on the composed model, they are copied up (to the "base") of the parent model (in this case a MonsterTruckRally).

Note: Currently does not pass the attribute information (the field of the composed model) along to its parent. Errors are added to "base".

Only supported option currently is `allow_nil: true`:

    also_validates :beer, :belly, allow_nil: true

Which, as the option states, allows nil values and will not attempt to validate those models.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
