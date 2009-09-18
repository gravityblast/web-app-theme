require "rubygems"
require "cucumber/rake/task"
require "spec/rake/spectask"

Cucumber::Rake::Task.new

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['test/**/*_spec.rb']
end

task :default => [:spec, :cucumber]