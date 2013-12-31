require 'nokogiri'

module EPUB
	class WordCountDocument < Nokogiri::XML::SAX::Document
		
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
		end
		
		def start_element(name, attrs)
			if !@in_body 
				@in_body = true if (name == 'body')
				return
			end
			
			case name
			when 'ul', 'dl', 'ol'
				@indent += 1
			when 'a'
				@attrs = attrs
			when 'img'
				alt = get_attr('alt', attrs)
				src = get_attr('src', attrs)
				append_output "![#{alt}](#{src})"
			when 'hr'
			#	append_output "---------------------------------------\n\n"
			when 'br'
			#	append_output "     \n"
			end

			@stack.push @string
			@string = ''
		end
		
		def end_element(name)
			if name == 'body'
				@in_body = false
				return
			end
			
			if !@in_body
				return
			end
			
			text = @string
			@string = @stack.pop
			
			if !text.empty?			
				case name
				when 'h1'
					append_output "# #{text}\n\n"
				when 'h2'
					append_output "## #{text}\n\n"
				when 'h3'
					append_output "### #{text}\n\n"
				when 'h4'
					append_output "#### #{text}\n\n"
				when 'h5'
					append_output "##### #{text}\n\n"
				when 'h6'
					append_output "###### #{text}\n\n"
				when 'p'
					append_output "#{text}\n\n"
				when 'dt'
					append_output "* **#{text}**\n"
				when 'li', 'dd'
					append_output "* #{text}\n"
				when 'dl', 'ul', 'ol'
					@indent -= 1
					append_output "#{text}\n"
				when 'pre'
					lines = text.split("\n")
					lines.each { |line| append_output "\t#{line}\n"}
					append_output "\n"
				when 'span'
					append_output(text)
					@attrs = nil
				when 'a'
					href = get_attr('href', @attrs)
				
					if !href.empty?
						append_output("[#{text}](#{href})")
					end
					
					@attrs = nil
				when 'i', 'em'
					if !text.empty?
						append_output("*#{text}*")
					end
				when 'b', 'strong'
					if !text.empty?
						append_output("**#{text}**")
					end
				else
					append_output(text)
				end
			end
			
			if @stack.length == 0
				do_output
			end
		end
		
		def cdata_block(string)
			if !@in_body || string.strip.empty?
				return
			end
			
			strip_string(string)
			@string += string
		end
		
		def characters(string)
			if !@in_body || string.strip.empty?
				return
			end
			
			strip_string(string)
			@string += string
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
		
		def strip_string(text)
			text.gsub!(/\s{2,}/, " ")
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
		
		def do_output(options = {})
			if !@string.empty?
				indent = @indent
				
				if options[:skip_indent]
					indent = (@indent <= 1) ? 0 : @indent - 1
				end
				
				puts "#{"\t" * indent}#{@string}"
				@string = ''
#				count_words
			end
		end
		
		def append_output(string)
			if !string.empty?
				@string = "#{@string}#{string}"
			end
		end
		
	end
end