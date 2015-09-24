require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'

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
