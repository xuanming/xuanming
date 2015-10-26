$:.push File.expand_path('../lib', __FILE__) unless $:.include?('lib')
require 'freeze/version'

Gem::Specification.new do |s|
  s.name          = 'freeze'
  s.version       = Freeze::VERSION
  s.summary       = 'Freeze'
  s.description   = 'Freeze static site generator'
  s.license       = 'MIT'
  s.authors       = %w[Xianghu Zhao]
  s.email         = %w[xianghuzhao@gmail.com]
  s.homepage      = 'http://rubygems.org/gems/freeze'

  s.files         = %w[CHANGELOG.md LICENSE.md README.md]
  s.files         += Dir.glob('lib/**/*.rb')
  s.files         += Dir.glob('bin/**/*')

  s.executable    = 'freeze'
end