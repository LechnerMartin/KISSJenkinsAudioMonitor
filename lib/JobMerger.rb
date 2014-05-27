class JobMerger

	def merge(list1, list2)
		hash = Hash.new
		list = [list1, list2].flatten.compact
		list.each{|elem|
			key = elem.name
			hash[key] << elem if hash.has_key?(key)
			hash[key] = [elem] unless hash.has_key?(key)
		}
		hash
	end

end

