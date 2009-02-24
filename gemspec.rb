require 'rake'
#require 'mkmf'

SPEC = Gem::Specification.new do |spec|
  # Descriptive and source information for this gem.
  spec.name = "pixiedust"
  spec.version = "0.0.11"
  spec.summary = "Assorted little utility functions for Ruby"
  spec.author = "Jonathan Wilkins"
  spec.email = "jwilkins[at]nospam[dot]bitland[dot]net"
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README.txt", 'Manifest.txt', 'History.txt']
  spec.require_path = "."
  spec.autorequire = "pixiedust.rb"

  unfiltered_files = FileList['*', 'examples/*', 'bin/*', 'test/*', 'lib/*']
  spec.files = unfiltered_files.delete_if do |filename|
    filename.include?(".gem") || filename.include?("Makefile") ||
    filename.include?(".so")  || filename.include?(".o")
  end
  spec.executables = []

  # optional native component
  #if cc_command
  #  spec.extensions << 'ext/extconf.rb'
  #end

  puts "Building gem w/ "
  spec.files.each do |f|
    puts "- #{f}"
  end

end
