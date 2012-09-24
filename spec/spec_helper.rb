require "rubygems"
require "bundler/setup"
require "shoulda-matchers"

require "also_validates"
require "fixtures/object_fixtures"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
