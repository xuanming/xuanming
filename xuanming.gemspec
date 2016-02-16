$:.push File.expand_path('../lib', __FILE__) unless $:.include?('lib')
require 'xuanming/version'

Gem::Specification.new do |s|
  s.name          = 'xuanming'
  s.version       = Xuanming::VERSION
  s.summary       = 'Xuanming'
  s.description   = 'Xuanming static site generator'
  s.license       = 'MIT'
  s.authors       = %w[Xianghu Zhao]
  s.email         = %w[xianghuzhao@gmail.com]
  s.homepage      = 'http://rubygems.org/gems/xuanming'

  s.files         = %w[CHANGELOG.md CONTRIBUTING.md LICENSE README.md]
  s.files         += Dir.glob('lib/**/*.rb')
  s.files         += Dir.glob('bin/**/*')

  s.executable    = 'xuanming'

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec"
end
