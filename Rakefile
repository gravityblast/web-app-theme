require "rubygems"
require "cucumber/rake/task"

Cucumber::Rake::Task.new

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task :default => [:spec, :cucumber]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "web-app-theme"
    gemspec.summary = "Web app theme generator"
    gemspec.description = "Web app theme generator for rails projects"
    gemspec.email = "andrea@gravityblast.com"
    gemspec.homepage = "http://github.com/pilu/web-app-theme"
    gemspec.authors = ["Andrea Franz"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end