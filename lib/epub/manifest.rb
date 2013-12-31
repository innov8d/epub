module EPUB
	class Manifest
		
		IMAGE_TYPES = [ 'image/jpeg', 'image/png' ]
		
		def initialize(xml_node)
			if !xml_node
				raise 'No manifest node.'
			end
			
			@items = get_items(xml_node)
		end
		
		def items
			@items 
		end
		
		def image_items
			@items.select { |item| IMAGE_TYPES.any? { |mimetype| mimetype == item[:media_type]} }
		end
		
		def html_items
			@items.select { |item| item[:media_type] == 'application/xhtml+xml' }
		end
		
		def get(id)
			@items.select { |item| item[:id] == id }.first
		end
		
		private
		
		def get_items(xml_node)
			nodes = xml_node.xpath("//opf:item", opf: 'http://www.idpf.org/2007/opf')
			
			if !nodes
				return []
			end
			
			nodes.map do |node|
				{
					id: node['id'],
					href: node['href'],
					media_type: node['media-type']
				}
			end
		end
		
	end
end