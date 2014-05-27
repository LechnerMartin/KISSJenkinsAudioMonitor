class TotalBuildStatusCalculator

	def calculateStatus(statusChangeList)
		@list = statusChangeList
		hasNoChangeFail = statusChangeList.include?(:NOCHANGEFAIL)
		hasFailed = statusChangeList.include?(:FAILED)
		hasFixed = statusChangeList.include?(:FIXED)
		hasStillFailing = statusChangeList.include?(:STILLFAILING)

		return "NewFailure" if hasNoChangeFail && hasFailed
		return "OneFixed" if hasNoChangeFail && hasFixed
		
		return "NewFailure" if hasFailed && ( hasFixed || hasStillFailing)
		return "OneFixed" if hasFixed && hasStillFailing
		return "FirstFailure" if hasFailed
		return "LastFixed" if hasFixed
		return "StillFailing" if hasStillFailing
		"OK"
	end
	
	def listContains(values)
#		values.collect{|value| @list.include?(value)}.inclued
	end

end

