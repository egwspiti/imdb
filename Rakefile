require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'
require_relative 'spec/fixtures'

YARD::Rake::YardocTask.new do |t|

end

task :default => :spec
RSpec::Core::RakeTask.new('spec') do |t|

end

desc "Start pry console with mtransform required."
task :pry do
  require 'imdb'
  require 'pry'
  binding.pry
end

desc "Fetch imdb webpage for id and save it into fixtures/"
task :fixture, :id do |t, args|
  puts "Fetching and saving fixture for imdb id:#{args[:id]}"
  Fixtures::save_id(args[:id])
end
