require 'rake/testtask'
require 'fileutils'

PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

Rake::TestTask.new do |t|
  t.libs << PROJECT_ROOT
  t.test_files = FileList["test/test*.rb"]
  t.verbose = true
end

# TODO add rake clean to clear out tmp
task :clean do
  FileUtils.rm_rf Dir.glob("#{PROJECT_ROOT}/tmp/*")
  FileUtils.rm_rf Dir.glob("#{PROJECT_ROOT}/test/tmp/*")
  #FileUtils.rm("#{PROJECT_ROOT}/tmp/*", :verbose => true)
  #FileUtils.rm("#{PROJECT_ROOT}/test/tmp/*", :verbose => true)
  puts "Done cleaning."
end
