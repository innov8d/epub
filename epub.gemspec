# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'epub/version'

Gem::Specification.new do |s|
	s.name        = 'epub'
	s.version     = EPUB::VERSION
	s.authors     = ['Dan Pratt']
	s.email       = %w{dpratt@innov8d.com}
	s.homepage    = ''
	s.summary     = %q{Scribl EPUB Parser}
	s.description = %q{Scribl EPUB Parser}

	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
	s.require_paths = %w{lib}

  s.add_runtime_dependency 'zipruby'
end
