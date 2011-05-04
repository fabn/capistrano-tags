# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "capistrano-tags"
  gem.homepage = "http://github.com/fabn/capistrano-tags"
  gem.license = "MIT"
  gem.summary = %Q{Capistrano recipe to deploy svn and git tags}
  gem.description = %Q{Use this recipe if you want to be able to deploy scm tags (or branches) with no need to edit your main deploy.rb file. You can choose the deployed tag using ENV variables or interactively decide which is the tag to deploy. }
  gem.email = "f.napoleoni@gmail.com"
  gem.authors = ["Fabio Napoleoni"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = '--exclude /gems/,/Library/,/usr/,lib/tasks,.bundle,config,/lib/rspec/,/lib/rspec-'
end

task :default => :spec
