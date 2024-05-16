# frozen_string_literal: true

require_relative 'lib/ecs-rails/version'

Gem::Specification.new do |s|
  s.name        = "ecs-rails"
  s.version     = EcsRails::VERSION
  s.summary     = "Connect to your AWS ECS tasks"
  s.description = "Connect to your AWS ECS tasks"
  s.authors     = ["Franck D'agostini"]
  s.email       = "franck.dagostini@gmail.com"
  s.homepage    = "https://rubygems.org/gems/ecs-rails"
  s.license       = "MIT"
  s.required_ruby_version = '>= 2.7.0'
  s.require_paths = ['lib']

  s.files = `git ls-files -z`.split("\x0")

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }

  s.add_development_dependency 'byebug', '~> 11.1'
  s.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'

  s.add_runtime_dependency "aws-sdk-ecs", "~> 1.132", "> 1.132"
  s.add_runtime_dependency "aws-sdk-ec2", "~> 1.425", "> 1.425"
  s.add_runtime_dependency "tty-prompt", "~> 0.23", "> 0.23"
  s.add_runtime_dependency "activesupport", "> 5.2"
end
