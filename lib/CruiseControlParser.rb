require 'xml'

class ProjectDto
	attr_accessor  :name, :lastBuildStatus, :webUrl, :lastBuildLabel
	
	def to_s
	 "#{name}; #{lastBuildStatus}; #{lastBuildLabel}; #{webUrl}"
	end
end

class CruiseControlParser
	def parse(xmltext)
		return [] unless xmltext
		parser = XML::Parser.string(xmltext)
		@doc = parser.parse
		
		result = @doc.root.find("//Project")
		result.collect{|node| parseProjectNode(node)}
	end
	
	def parseProjectNode(node)
		project = ProjectDto.new
		project.name = node['name']
		project.webUrl = node['webUrl']
		project.lastBuildStatus = node['lastBuildStatus']
		project.lastBuildLabel = node['lastBuildLabel'].to_i
		project
	end
	
end


