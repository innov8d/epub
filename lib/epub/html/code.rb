module EPUB
	module HTML
		class Code < Generic
			
			def render
				string = text
				output = []
				
				string.split("\n").each do |line|
					if !blank?(strip(line))
						output << "\t#{line}\n"
					end
				end
				
				if output.length > 0
					output << "\n"
				end
				
				output
			end
			
		end
	end
end
