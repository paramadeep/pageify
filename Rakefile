require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/packagetask'
require 'rubygems/tasks'

Gem::Tasks.new(
    :build => {:gem => true},
     :sign => {:checksum => true, :pgp => true}
)

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
