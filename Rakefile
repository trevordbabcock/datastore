require 'rake/testtask'
require 'fileutils'

PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

Rake::TestTask.new do |t|
  FileUtils.rm_rf Dir.glob("#{PROJECT_ROOT}/test/tmp/*")
  t.libs << PROJECT_ROOT
  t.test_files = FileList["test/test*.rb"]
  t.verbose = true
end

# TODO add rake clean to clear out tmp
task :clean do
  FileUtils.rm_rf Dir.glob("#{PROJECT_ROOT}/test/tmp/*")
  puts "Done cleaning."
end
