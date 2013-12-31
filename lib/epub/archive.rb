require 'zipruby'
require 'nokogiri'

module EPUB
	class Archive
		
		def initialize(filename)
			@archive = Zip::Archive.open(filename)
		end
		
		def filenames
			@filesnames ||= get_filenames
		end
		
		def get(filename)
			@archive.fopen(filename)
		end
		
		private
		
		def get_filenames
			@archive.map do |f|
				f.name
			end
		end
		
	end
end