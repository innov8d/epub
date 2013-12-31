module EPUB
	class Spine
		
		def initialize(xml_node)
			if !xml_node
				raise 'No manifest node.'
			end
			
			@items = get_items(xml_node)
		end
		
		def items
			@items
		end
		
		private
		
		def get_items(xml_node)
			nodes = xml_node.xpath("//opf:itemref", opf: 'http://www.idpf.org/2007/opf')
			
			if !nodes
				return []
			end
			
			nodes.map do |node|
				{
					idref: node['idref']
				}
			end
		end
		
	end
end
