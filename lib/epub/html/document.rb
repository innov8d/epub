
#			when 'ul', 'dl', 'ol'
#				@indent += 1
#			when 'a'
#				@attrs = attrs
#			when 'img'
#				alt = get_attr('alt', attrs)
#				src = get_attr('src', attrs)
#				append_output "![#{alt}](#{src})"
#			when 'hr'
			#	append_output "---------------------------------------\n\n"
#			when 'br'
			#	append_output "     \n"
#			end
#		end

#			text = @string
#			@string = @stack.pop
						
			# case name
			# when 'h1'
				# strip_string(text)
				# append_output "# #{text}\n\n"
			# when 'h2'
				# strip_string(text)
				# append_output "## #{text}\n\n"
			# when 'h3'
				# strip_string(text)
				# append_output "### #{text}\n\n"
			# when 'h4'
				# strip_string(text)
				# append_output "#### #{text}\n\n"
			# when 'h5'
				# strip_string(text)
				# append_output "##### #{text}\n\n"
			# when 'h6'
				# strip_string(text)
				# append_output "###### #{text}\n\n"
			# when 'p'
				# strip_string(text)
				# append_output "#{text}\n\n"
			# when 'dt'
				# strip_string(text)
				# append_output "* **#{text}**\n"
			# when 'li', 'dd'
				# strip_string(text)
				# append_output "* #{text}\n"
			# when 'dl', 'ul', 'ol'
				# @indent -= 1
				# append_output "#{text}\n"
			# when 'pre'
				# lines = text.split("\n")
				# lines.each { |line| append_output "\t#{line}\n"}
				# append_output "\n"
			# when 'span'
				# append_output(text)
				# @attrs = nil
			# when 'a'
				# href = get_attr('href', @attrs)
				# 
				# if !href.empty?
				# 	append_output("[#{text}](#{href})")
				# end
				# 	
				# @attrs = nil
			# when 'i', 'em'
				# if !text.empty?
				# 	append_output("*#{text}*")
				# end
			# when 'b', 'strong'
				# if !text.empty?
				# 	append_output("**#{text}**")
				# end
			# else
				# append_output(text)
			# end
			#end

require 'nokogiri'

module EPUB
	module HTML
		class Document < Nokogiri::XML::SAX::Document
		
			def word_count
				@word_count || 0
			end
		
			def start_document
				@in_body = false
				@word_count = 0
				@indent = 0
				@string = ''
				@stack = []
				@attrs = nil
				@current = nil
			end
		
			def start_element(name, attrs)
				if !@in_body 
					@in_body = true if (name == 'body')
					return
				end

				case name
				when 'h1'
					new_node = H.new(1, attrs)
				when 'h2'
					new_node = H.new(2, attrs)
				when 'h3'
					new_node = H.new(3, attrs)
				when 'h4'
					new_node = H.new(4, attrs)
				when 'h5'
					new_node = H.new(5, attrs)
				when 'h6'
					new_node = H.new(6, attrs)
				when 'dl', 'ul', 'ol'
					new_node = List.new
				when 'dt'
					new_node = DT.new
				when 'dd', 'li'
					new_node = DD.new
				when 'p'
					new_node = P.new(attrs)
				when 'div'
					new_node = DIV.new
				when 'br'
					new_node = BR.new
				when 'hr'
					new_node = HR.new
				when 'pre', 'code'
					new_node = Code.new
				when 'a'
					new_node = A.new(attrs)
				when 'span'
					new_node = SPAN.new
				when 'em', 'i'
					new_node = EM.new
				when 'strong', 'b'
					new_node = STRONG.new
				when 'img'
					new_node = IMG.new(get_attr('src', attrs), get_attr('alt', attrs))
				else
					new_node = Generic.new(name)
				end

				if !@current.nil?
					@stack.push @current
					@current.add_child(new_node)
				end

				@current = new_node
				
				#puts @current.inspect
			end
		
			def end_element(name)
				if name == 'body'
					@in_body = false
					return
				end
			
				if !@in_body
					return
				end

				if @stack.length == 0
					do_output
					@current = nil
				else
					@current = @stack.pop
				end
			end
			
			def cdata_block(string)
				if @current.nil? 
					return
				end
			
				@current.add_child(string)
			end
		
			def characters(string)
				if @current.nil? 
					return
				end
			
				@current.add_child(string)
			end
		
			private
		
			def count_words
				if @string.empty?
					return
				end
			
				length = @string.split.length
				@string = ''
			
				@word_count += length
			end
		
			def get_attr(name, attrs)
				if attrs.nil?
					return ""
				end
			
				attr = attrs.select { |attr| attr[0] == name }.first
			
				if attr.nil?
					return ""
				end
			
				attr[1]
			end

			def do_output
				if @current.nil?
					return
				end
				
				output = @current.render.join('').gsub(/\n{3,}/, "\n\n")
				print output
			end
		
		end
	end
end