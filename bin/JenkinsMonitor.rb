#!/usr/bin/ruby

require_relative  '../lib/MonitorMain'

if __FILE__ == $PROGRAM_NAME
	file1 = ARGV[0]	
	file2 = ARGV[1]	
	monitor = MonitorMain.new
	puts monitor.check(file1, file2)
end
