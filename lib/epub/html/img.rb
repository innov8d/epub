module EPUB
	module HTML
		class IMG < Generic
			
			def initialize(src, alt)
				super()
				
				@alt = alt
				@src = src
			end
			
			def render
				text = super.join('')
				output = []
				
				if !blank?(@src)
					output << "![#{strip(@alt)}](#{@src})     \n"
				end
				
				output
			end
		end
	end
end
