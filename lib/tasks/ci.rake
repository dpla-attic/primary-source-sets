desc "Prepare for CI and run entire test suite"
task :ci => ['ci:build'] do
  Rake::Task['spec'].invoke
end

namespace :ci do
  desc "Prepare for CI and run entire test suite"
  task :build do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
end
