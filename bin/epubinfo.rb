require 'epub'

epub = EPUB.parse(ARGV[0])

puts "Title: #{epub.title}"
puts "ID: #{epub.identifier}"
puts "Language: #{epub.language}"
puts "Description: #{epub.description}"
puts "Cover Manifiest ID: #{epub.metadata.cover_id}"
puts "Cover Filename: #{epub.cover_filename}"
puts "NR Images: #{epub.image_items.length}"
puts "NR HTMLs: #{epub.html_items.length}"
puts "Spine items: #{epub.spine.items.inspect}"
puts "Word Count: #{epub.word_count}"