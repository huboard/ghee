require "bundler/gem_tasks"

require "rspec/core/rake_task"
desc "Run the specs"
RSpec::Core::RakeTask.new do |t|
  #t.rspec_opts = %w(-fs --color)
end

task :default => :spec
task :test => :spec

desc "Run the api specs"
RSpec::Core::RakeTask.new do |t|
  t.name = :api
  t.pattern = "spec/ghee/api/*_spec.rb"
end

desc "Open an irb session with library"
task :console do 
  sh "irb -I lib -r ghee"
end

desc "clean out VCR responses"
task :clean do
  sh "rm -rf spec/responses"
end
