module EPUB
	module HTML
		class DD < Generic
			
			def render
				output = super
				
				if output.length > 0

					output[0] = "* #{output[0]}"
					
					if (output.length == 1) && !output[0].match(/.*\n$/)
						output[0] = "#{output[0]}\n"
					end
					
					if (output.length > 1) && (output.last != "\n")
						output << "\n"
					end
				end
				
				output
			end
			
		end
	end
end
