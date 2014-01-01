module EPUB
	module HTML
		class Generic
			
			def initialize(name = nil, attrs = {})
				@name = name
				@attrs = attrs
				@children = []
			end
			
			def children
				@children
			end
			
			def add_child(child)
				if !(blank?(child) || (child.is_a?(String) && blank?(strip(child))))
					children << child
				end
			end
			
			def text
				string = ''
				
				children.each do |child|
					if child.is_a?(String)
						string = "#{string}#{child}"
					else
						string = "#{string}#{child.text}"
					end
				end
				
				strip(string)
			end
			
			def id
				get_attr('id')
			end
			
			def classes
				get_attr('class')
			end
			
			def title
				get_attr('title')
			end
			
			def attributes
				output = []
				
				if !blank?(id)
					output << "{:##{id}}"
				end
				
				if !blank?(classes)
					classes.split(' ').each do |cls|
						output << "{:.#{cls}}"
					end
				end
				
				output
			end
			
			def render
				output = []
				
				children.each do |child|
					if child.is_a?(String)
						output << child
					else
						output += child.render
					end
				end
				
				output
			end
			
			def strip(string)
				string.gsub(/\s+/, " ").strip
			end
			
			def blank?(string)
				if string.is_a?(String)
					return string.empty?
				end
				
				return string.nil?
			end
			
			def get_attr(name)
				if @attrs.nil?
					return ""
				end
			
				attr = @attrs.select { |attr| attr[0] == name }.first
			
				if attr.nil?
					return ""
				end
			
				attr[1]
			end
			
		end
	end
end
