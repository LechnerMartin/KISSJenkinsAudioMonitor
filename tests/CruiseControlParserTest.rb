require "test/unit"
require_relative  '../lib/CruiseControlParser'

INPUT = <<XMLTEXT
<Projects>
<Project webUrl="https://ci.jenkins.at/job/accounts-jtf-650/" name="accounts-jtf-650" lastBuildLabel="34" lastBuildTime="2014-01-14T19:59:14Z" lastBuildStatus="Success" activity="Sleeping"/>
<Project webUrl="https://ci.jenkins.at/job/balance-jtf-651/" name="balance-jtf-651" lastBuildLabel="62" lastBuildTime="2014-01-14T20:22:29Z" lastBuildStatus="Failure" activity="Sleeping"/>
<Project webUrl="https://ci.jenkins.at/job/billing-jtf-653/" name="billing-jtf-653" lastBuildLabel="7" lastBuildTime="2014-02-14T20:22:29Z" lastBuildStatus="Failure" activity="Sleeping"/>
</Projects>
XMLTEXT

class CruiseControlParserTest < Test::Unit::TestCase
	def setup
		@parser = CruiseControlParser.new
		@projects = @parser.parse(INPUT)
	end

#<Project webUrl="" name="1" lastBuildLabel="62" lastBuildTime="" lastBuildStatus="Failure" activity="Sleeping"/>

	def testParseProjectsBasic
		assert_equal(3, @projects.size)
	end

	def testParseProjectNames
		assert_equal("accounts-jtf-650", @projects[0].name)
		assert_equal("balance-jtf-651", @projects[1].name)
		assert_equal("billing-jtf-653", @projects[2].name)
	end

	def testParseProjectWebUrl
		assert_equal("https://ci.jenkins.at/job/accounts-jtf-650/", @projects[0].webUrl)
		assert_equal("https://ci.jenkins.at/job/balance-jtf-651/", @projects[1].webUrl)
	end
	
	def testParseProjectBuildStatus
		assert_equal("Success", @projects[0].lastBuildStatus)
		assert_equal("Failure", @projects[1].lastBuildStatus)
	end

	def testParseEmptyProjects
		assert_equal(0, @parser.parse("<Projects/>").size)
		assert_equal(0, @parser.parse("<Projects></Projects>").size)
	end

	def testParseInvalid # raise exception???
		assert_equal(0, @parser.parse(nil).size)
		#assert_equal(0, @parser.parse("").size)
		#assert_equal(0, @parser.parse("Hello").size)
	end
	
	def testParseBuildLabel
		assert_equal(34, @projects[0].lastBuildLabel)
		assert_equal(62, @projects[1].lastBuildLabel)
	end


end
