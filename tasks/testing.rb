require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rspec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rcov = true
  t.rcov_opts = [
    '--exclude', 'spec',   '--exclude', 'gems',
    '--exclude', 'riddle', '--exclude', 'ruby'
  ]
end
