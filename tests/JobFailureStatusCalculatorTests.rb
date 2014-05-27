require "test/unit"
require_relative  '../lib/JobFailureStatusCalculator'

class MockDto
	attr_accessor  :name, :lastBuildStatus, :webUrl, :lastBuildLabel
end

class JobFailureStatusCalculatorTest < Test::Unit::TestCase
	def setup
		@calc = JobFailureStatusCalculator.new
		@project1Ok1 = getTestMock("Success", 1, "project1") 
		@project1Ok2 = getTestMock("Success", 2, "project1") 
		@project1Nok1 = getTestMock("Failure", 1, "project1") 
		@project1Nok2 = getTestMock("Failure", 2, "project1") 
		@project1Unknown1 = getTestMock("Unknown", 1, "project1") 
		@project1Unknown2 = getTestMock("Unknown", 2, "project1") 
	end
	
	def testUnknownStatus
		assert_equal(:OK, @calc.calculateStatusChanges(@project1Unknown1,@project1Ok2))
		assert_equal(:OK, @calc.calculateStatusChanges(@project1Unknown2,@project1Ok1))
		assert_equal(:OK, @calc.calculateStatusChanges(@project1Unknown1,@project1Unknown2))
	end
	
	def testEmptyCalculations
		assert_equal(:OK, @calc.calculateStatusChanges(nil,nil))
		assert_equal(:OK, @calc.calculateStatusChanges(nil,[@project1Ok1]))
		assert_equal(:OK, @calc.calculateStatusChanges(@project1Ok1,nil))
	end
	
	def testStatusChangesOkToOk
		assert_equal(:OK, @calc.calculateStatusChanges(@project1Ok1, @project1Ok2))
	end

	def testStatusChangesOkToNok
		assert_equal(:FAILED, @calc.calculateStatusChanges(@project1Ok1, @project1Nok2))
	end

	def testStatusChangesNokToOk
		assert_equal(:FIXED, @calc.calculateStatusChanges(@project1Nok1,@project1Ok2))
	end

	def testStatusChangesNokToNok
		assert_equal(:STILLFAILING, @calc.calculateStatusChanges(@project1Nok1,@project1Nok2))
	end

	def testBothLabelsSame
		assert_equal(:NOCHANGE, @calc.calculateStatusChanges(@project1Ok1,@project1Ok1))
		assert_equal(:NOCHANGEFAIL, @calc.calculateStatusChanges(@project1Nok1,@project1Nok1))
	end

	def testNewerLabelSmaller
		assert_equal(:FIXED, @calc.calculateStatusChanges(@project1Ok2,@project1Nok1))
	end

	def testDifferentProjects
		@project2Ok = getTestMock("Success", 5, "project2") 
		assert_equal("project2", @project2Ok.name)
		assert_equal("project1", @project1Ok1.name)
		assert_raises(RuntimeError) {@calc.calculateStatusChanges(@project2Ok,@project1Ok1)}
	end
	
	def getTestMock(status, label, name)
		mock = MockDto.new
		mock.lastBuildStatus = status
		mock.lastBuildLabel = label
		mock.name = name
		mock
	end
	
end
