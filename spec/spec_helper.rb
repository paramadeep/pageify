require 'bundler/setup'
Bundler.setup

require 'pageify'

require 'simplecov'
SimpleCov.start
SimpleCov.minimum_coverage 100
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

RSpec.configure do |config|
end
