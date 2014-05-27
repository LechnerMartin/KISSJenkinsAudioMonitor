require "test/unit"
require_relative  '../lib/MonitorMain'

class MonitorMainFunctionalTest < Test::Unit::TestCase

	def testFirstFailure
		path = File.expand_path(File.dirname(__FILE__))
		monitor = MonitorMain.new
		file1 = "#{path}/../testdata/cc-test_allOk.xml"
		file2 = "#{path}/../testdata/cc-test_oneFailed.xml"
		assert_equal("FirstFailure", monitor.check(file1, file2))
	end
end
