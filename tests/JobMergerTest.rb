require "test/unit"
require_relative  '../lib/JobMerger'

class MockDto
	attr_accessor  :name
end

class JobMergerTest < Test::Unit::TestCase
	def setup
		@merger =JobMerger.new
		@job1a = createMock("job1")
		@job1b = createMock("job1")
		@job2a = createMock("job2")
		@job2b = createMock("job2")
	end

	def testEmptyMerge
		assert_equal(Hash.new, @merger.merge([], []))
		assert_equal(Hash.new, @merger.merge(nil, []))
	end
	
	def testMergeSingleJob
		assert_equal({"job1" => [@job1a, @job1b]}, @merger.merge([@job1a], [@job1b]))
	end

	def testMergeJobs
		result = @merger.merge([@job2a, @job1a], [@job1b, @job2b])
		assert_equal([@job2a, @job2b], result["job2"])
		assert_equal([@job1a, @job1b], result["job1"])
	end

	def testMergeUnevenJobs
		result = @merger.merge([@job2a], [@job1b])
		assert_equal([@job2a], result["job2"])
		assert_equal([@job1b], result["job1"])
	end

	
	def createMock(name)
		dto = MockDto.new
		dto.name = name
		dto
	end
end
