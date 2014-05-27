# read 2 files into string
# parse files and get jobs 
# merge jobs
# get status for all jobs
# get final status 
# return status
require_relative  '../lib/JobMerger'
require_relative  '../lib/JobFailureStatusCalculator'
require_relative  '../lib/TotalBuildStatusCalculator'
require_relative  '../lib/CruiseControlParser'

class MonitorMain
	def initialize
		@parser = CruiseControlParser.new
		@merger =JobMerger.new
		@statusCalculator = JobFailureStatusCalculator.new
		@resultCalculator = TotalBuildStatusCalculator.new
	end
	
	def check(file1, file2)
		jobs1 = getJobs(file1)
		jobs2 = getJobs(file2)
		mergedJobs = @merger.merge(jobs1, jobs2)
		states = getStates(mergedJobs)
		@resultCalculator.calculateStatus(states)
	end
	
	def getJobs(file)
		txt = readFile(file)
		@parser.parse(txt)
	end
	
	def readFile(file)
		File.open(file, 'rb') { |f| f.read }
	end
	
	def getStates(mergedJobs)
		mergedJobs.values.collect{|jobs|
			@statusCalculator.calculateStatusChanges(jobs[0],jobs[1])
		}
	end
	
end
