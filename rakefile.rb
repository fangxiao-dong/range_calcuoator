require 'rake/testtask'

Rake::TestTask.new do |t|
  t.verbose = true
  t.test_files = FileList['range_calculator_test.rb']
end
