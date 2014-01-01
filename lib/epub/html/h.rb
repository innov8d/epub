module EPUB
	module HTML
		class H < Generic
			
			def initialize(level, attrs)
				@level = level
				
				if @level < 1
					@level = 1
				elsif @level > 6
					@level = 6
				end
				
				super("h#{@level}", attrs)
			end
			
			def render
				output = []
				string = super.join('')
				
				if !string.empty?
					output << "\n\n"
					output << "#{'#' * @level} #{string}\n"
					attributes.each do |attr|
						output << "#{attr}\n"
					end
					output << "\n"
				end
				
				output
			end
			
		end
	end
end
