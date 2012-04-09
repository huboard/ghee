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

MATCHES = [:method, :host, :path]

CACHED = YAML.load_file(File.expand_path("../cached.yml", __FILE__))

# Check to see if cached responses exist. If they do use the default user/pass/token/org/repo.
# If they do not exist look for a settings.yml and run tests against the GitHub API.
# When there are no responses and no settings.yml go ahead and let us know.
settings_file = File.expand_path("../settings.yml", __FILE__)
responses_dir = File.expand_path("../responses", __FILE__)

if File.directory?(responses_dir) && Dir.entries(responses_dir).length > 2
  GH_AUTH = {:user_name => "johndoe", :password => "omgbbq"}
  GH_USER, GH_REPO, GH_ORG = "johndoe", "ghee_test_repo", "acme"
elsif File.exists?(settings_file)
  settings = YAML.load_file(settings_file)

  GH_AUTH = if settings['access_token']
    {:access_token => settings['access_token']}
  else
    {:basic_auth => {:user_name => settings['username'], :password => settings['password']}}
  end

  GH_USER, GH_REPO, GH_ORG = settings['username'], settings['repo'], settings['org']
else
  puts "\nProblem running against cached responses or settings.yml does not exist.\n\n"
end