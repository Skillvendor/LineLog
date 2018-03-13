# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'line_log/version'

Gem::Specification.new do |spec|
  spec.name          = "line_log"
  spec.version       = LineLog::VERSION
  spec.authors       = ["Skillvendor"]
  spec.email         = ["skillvendor193@gmail.com"]

  spec.summary       = %q{ custom logger for rack based applications }
  spec.description   = %q{ LineLog is built to help you have customs logs in sinatra(should support any rack application but it is not tested for that). LineLog welcomes contribution that would make it better and also any constructive feedback.}
  spec.homepage      = "https://github.com/Skillvendor/LineLog"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/Skillvendor/LineLog"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end