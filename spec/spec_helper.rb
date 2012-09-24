require "rubygems"
require "bundler/setup"
require "validation_aggregator"
require "shoulda-matchers"

require "fixtures/object_fixtures"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
