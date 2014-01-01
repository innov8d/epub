module EPUB
	module HTML
		class P < Generic
			def initialize(attrs)
				super('p', attrs)
			end
			
			def render
				output = strip(super.join(''))
				
				if output.length == 0
					return []
				end
				
				output = ["#{output}\n"]
				attributes.each do |attr|
					output << "#{attr}\n"
				end
				output << "\n"
				
				output
				
			end
		end
	end
end
