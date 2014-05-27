require "test/unit"
require_relative  '../lib/TotalBuildStatusCalculator'

class TotalBuildstatusCalculator < Test::Unit::TestCase
	def setup
		@calc = TotalBuildStatusCalculator.new
	end
	
	def testAllOk
		assert_equal("OK", @calc.calculateStatus([:OK]))
		assert_equal("OK", @calc.calculateStatus([:NOCHANGE]))
	end

	def testNoChange
		assert_equal("FirstFailure", @calc.calculateStatus([:FAILED,:NOCHANGE]))
		assert_equal("OK", @calc.calculateStatus([:OK,:NOCHANGE]))
	end

	def testNoChangeFail
		assert_equal("OK", @calc.calculateStatus([:OK,:NOCHANGEFAIL]))
		assert_equal("NewFailure", @calc.calculateStatus([:FAILED,:NOCHANGEFAIL]))
		assert_equal("OneFixed", @calc.calculateStatus([:FIXED,:NOCHANGEFAIL]))
		assert_equal("StillFailing", @calc.calculateStatus([:STILLFAILING,:NOCHANGEFAIL]))
	end
	
	def testFirstFailure
		assert_equal("FirstFailure", @calc.calculateStatus([:FAILED, :OK]))
	end

	def testLastFixed
		assert_equal("LastFixed", @calc.calculateStatus([:FIXED, :OK]))
		assert_equal("LastFixed", @calc.calculateStatus([:FIXED, :FIXED]))
	end

	def testStillFailing
		assert_equal("StillFailing", @calc.calculateStatus([:STILLFAILING, :OK]))
	end

	def testNewFailure
		assert_equal("NewFailure", @calc.calculateStatus([:FAILED, :FIXED]))
		assert_equal("NewFailure", @calc.calculateStatus([:FAILED, :STILLFAILING]))
	end
	
	def testOneFixed
		assert_equal("OneFixed", @calc.calculateStatus([:FIXED, :STILLFAILING]))
	end

end
