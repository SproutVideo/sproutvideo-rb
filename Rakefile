# encoding: utf-8
require 'rubygems'
require 'bundler'

require File.expand_path(File.dirname(__FILE__) + '/lib/sproutvideo/version.rb')

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
  gem.name = "sproutvideo-rb"
  gem.homepage = "http://github.com/SproutVideo/sproutvideo-rb"
  gem.license = "MIT"
  gem.summary = %Q{SproutVideo API Client}
  gem.description = %Q{SproutVideo API Client}
  gem.email = "support@sproutvideo.com"
  gem.authors = ["SproutVideo"]
  # dependencies defined in Gemfile
  gem.version = Sproutvideo::VERSION
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
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sproutvideo-rb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
