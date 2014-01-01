module EPUB
	module HTML
		class STRONG < Generic
			
			def render
				output = []
				string = text
				
				if !(blank?(string))
					output << "**#{strip(string)}**"
				end
				
				output
			end
		end
	end
end
