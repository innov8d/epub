module EPUB
	module HTML
		class A < Generic
			
			def initialize(href)
				super()
				
				@href = href
			end
			
			def render
				text = super.join('')
				output = []
				
				if !(blank?(@href) || blank?(text))
					output << "[#{strip(text)}](#{@href})"
				end
				
				output
			end
		end
	end
end
