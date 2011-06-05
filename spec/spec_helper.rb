require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'vcr_setup'
require 'places'

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end