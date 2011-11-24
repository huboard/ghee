# encoding: UTF-8
require 'bundler'
Bundler.require :default, :test
require 'webmock/rspec'
require 'vcr'
require 'ghee'

VCR.config do |c|
  c.cassette_library_dir = File.expand_path('../responses', __FILE__)
  c.stub_with :webmock
  c.default_cassette_options = {:record => :once}
end

token_file = File.expand_path('../.access_token', __FILE__)
ACCESS_TOKEN = File.exists?(token_file) ? File.read(token_file).strip : 'faketoken'