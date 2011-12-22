require "bundler/gem_tasks"

require "rspec/core/rake_task"
desc "Run the specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(-fs --color)
end

task :default => :spec
task :test => :spec
