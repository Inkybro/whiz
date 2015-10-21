# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whiz/version'

Gem::Specification.new do |spec|
  spec.name          = "whiz"
  spec.version       = Whiz::VERSION
  spec.authors       = ["Ethan M. Barron"]
  spec.email         = ["ethan.michael.barron@gmail.com"]

  spec.summary       = %q{TODO: Whiz allows one to quickly generate custom boilerplate code.}
  spec.description   = %q{TODO: If you're tired of writing the same boilerplate code again and again, Whiz is for you. Whiz lets you manage custom code templates, and gives you tools that allow you to generate those templates at a later time.}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency "activesupport"
  spec.add_dependency "thor"
end
