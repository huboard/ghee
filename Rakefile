require "bundler/gem_tasks"

require "rspec/core/rake_task"
desc "Run the specs"
RSpec::Core::RakeTask.new do |t|
  #t.rspec_opts = %w(-fs --color)
end

task :default => [:spec, :scrub]
task :test => :default

desc "Open an irb session with library"
task :console do
  sh "irb -I lib -r ghee"
end

desc "Scrub response fixtures and remove sensitive usernames/orgs/passwords/tokens"
task :scrub do
  settings_file = File.expand_path("../spec/settings.yml", __FILE__)
  responses_dir = File.expand_path("../spec/responses", __FILE__)

  if File.exists?(settings_file)
    settings = YAML.load_file(settings_file)

    File.open(File.expand_path("../spec/cached.yml", __FILE__), 'w') do |f|
       f.write "username: #{settings['username']}\n"
       f.write "org: #{settings['org']}"
    end

    Dir.foreach(responses_dir) do |filename|
      next if filename == '.' or filename == '..'
      `sed -i "" -e 's/#{settings['username']}/johndoe/g' #{responses_dir}/#{filename}` if settings['username']
      `sed -i "" -e 's/#{settings['org']}/acme/g' #{responses_dir}/#{filename}` if settings['org']
      `sed -i "" -e 's/#{settings['access_token']}/lmfao/g' #{responses_dir}/#{filename}` if settings['access_token']
      `sed -i "" -e 's/#{settings['password']}/omgbbq/g' #{responses_dir}/#{filename}` if settings['password']
      new_filename = filename.gsub(/#{settings['username']}/, 'johndoe')
      `mv #{responses_dir}/#{filename} #{responses_dir}/#{new_filename}`
    end

    puts "\nFinished scrubbing.\n\n"
  else
    puts "\nFound no settings.yml to know what passwords/tokens to scrub.\n\n"
  end
end