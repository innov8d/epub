module EPUB
	class Metadata
		
		def initialize(xml_node)
			if !xml_node
				raise 'No metadata node.'
			end
			
			@xml = xml_node
		end
		
		def title
			@title ||= get_title
		end
		
		def identifier
			@identifier ||= get_identifier
		end
		
		def description
			@description ||= get_description
		end
		
		def language
			@language ||= get_language
		end
		
		def cover_id
			@cover_id ||= get_cover_id
		end
		
		private
		
		def get_title
			node = @xml.at_xpath("//dc:title/text()", dc: 'http://purl.org/dc/elements/1.1/')
			
			if !node
				return ''
			end
			
			node.content
		end
		
		def get_identifier
			node = @xml.at_xpath("//dc:identifier/text()", dc: 'http://purl.org/dc/elements/1.1/')
			
			if !node
				return ''
			end
			
			node.content
		end
		
		def get_description
			node = @xml.at_xpath("//dc:description/text()", dc: 'http://purl.org/dc/elements/1.1/')
			
			if !node
				return ''
			end
			
			node.content
		end
		
		def get_language
			node = @xml.at_xpath("//dc:language/text()", dc: 'http://purl.org/dc/elements/1.1/')
			
			if !node
				return ''
			end
			
			node.content
		end
		
		def get_cover_id
			attr = @xml.at_xpath("//opf:meta[@name='cover']/@content", opf: 'http://www.idpf.org/2007/opf')
			
			if !attr
				return ''
			end
			
			attr.value
		end
		
	end
end