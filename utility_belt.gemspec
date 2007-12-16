require 'rubygems' 
SPEC = Gem::Specification.new do |s| 
  s.name = "utility_belt"
  s.version = "1.0.5"
  s.author = "Giles Bowkett"
  s.email = "gilesb@gmail.com"
  s.homepage = "http://utilitybelt.rubyforge.org"
  s.platform = Gem::Platform::RUBY
  s.summary = "A grab-bag of IRB power user madness."
  s.files = Dir.glob("**/*")
  %w{amazon google}.each do |command_line_utility_for_interacting_with_a_gigantic_self_aware_ai|
    s.executables << command_line_utility_for_interacting_with_a_gigantic_self_aware_ai
  end
  s.require_path = "lib"
  s.autorequire = "utility_belt"
  s.test_file = "test/utility_belt_spec.rb"
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README"] 
  s.add_dependency("wirble", ">= 0.1.2")
  s.add_dependency("aws-s3", ">= 0.4.0")
  s.add_dependency("Platform", ">= 0.4.0")
end 
