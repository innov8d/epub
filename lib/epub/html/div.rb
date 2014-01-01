module EPUB
	module HTML
		class DIV < Generic
			def render
				output = []
			
				children.each do |child|
					if child.is_a?(String)
						output << strip(child)
					else
						output += child.render
					end
				end
				
				if (output.length > 0) && (output.last != "\n")
					output << "\n"
				end
				
				output
			end
		end
	end
end
