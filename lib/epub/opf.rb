require 'nokogiri'

module EPUB
	class OPF
		
		def initialize(file)
			@doc = Nokogiri::XML(file)
			
			if !@doc
				raise 'No OPF file'
			end
			
			if version != '2.0'
				raise "Unsupported version: #{version}"
			end
		end
		
		def version
			@version ||= get_version
		end
		
		def metadata
			@metadata ||= get_metadata
		end
		
		def manifest
			@manifest ||= get_manifiest
		end
		
		def spine
			@spine ||= get_spine
		end
		
		private
		
		def get_version
			attr = @doc.at_xpath('/opf:package/@version', opf: 'http://www.idpf.org/2007/opf')
			
			if !attr
				return ''
			end
			
			attr.value
		end
		
		def get_metadata
			Metadata.new(@doc.at_xpath('//opf:metadata', opf: 'http://www.idpf.org/2007/opf'))
		end
		
		def get_manifiest
			Manifest.new(@doc.at_xpath('//opf:manifest', opf: 'http://www.idpf.org/2007/opf'))
		end
		
		def get_spine
			Spine.new(@doc.at_xpath('//opf:spine', opf: 'http://www.idpf.org/2007/opf'))
		end
		
	end
end