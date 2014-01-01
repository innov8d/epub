module EPUB
	module HTML
		class BR < Generic
			
			def text
				" - "
			end
			
			def render
				["    \n"]
			end
			
		end
	end
end
