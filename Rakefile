require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = 'spec/*_test.rb'
end

task :spec
task :default => :spec
