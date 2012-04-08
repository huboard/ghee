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
if File.exists? File.expand_path("../settings.yml", __FILE__)
  settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__))
  GH_AUTH = settings['access_token'] ? {:access_token => settings['access_token']} : {:basic_auth => {:user_name => settings['username'], :password => settings['password']}}
  GH_USER, GH_REPO, GH_ORG = settings['username'], settings['repo'], settings['org']
else
  GH_AUTH = {:access_token => ENV["TOKEN"]}
  GH_USER, GH_REPO, GH_ORG = ENV['GH_USER'], ENV['GH_REPO'], ENV['GH_ORG']
end
