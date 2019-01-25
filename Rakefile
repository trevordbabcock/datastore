require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << File.expand_path(File.dirname(__FILE__))
  t.test_files = FileList["test/test*.rb"]
  t.verbose = true
end

# TODO add rake clean to clear out tmp
