class JobFailureStatusCalculator
	def calculateStatusChanges(oldstatus, newstatus)
		return :OK if oldstatus == nil || newstatus == nil
		raise "ERROR projects do not match" if oldstatus.name != newstatus.name
		if oldstatus.lastBuildLabel == newstatus.lastBuildLabel
			return :NOCHANGEFAIL if oldstatus.lastBuildStatus == "Failure"
			return :NOCHANGE 
		end
		
		
		oldstatus, newstatus = newstatus, oldstatus if oldstatus.lastBuildLabel > newstatus.lastBuildLabel
		
		return :FAILED if oldstatus.lastBuildStatus == "Success" && newstatus.lastBuildStatus == "Failure"
		return :FIXED if oldstatus.lastBuildStatus == "Failure" && newstatus.lastBuildStatus == "Success"
		return :STILLFAILING if oldstatus.lastBuildStatus == "Failure" && newstatus.lastBuildStatus == "Failure"
		:OK
	end
end
