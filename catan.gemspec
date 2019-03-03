Gem::Specification.new do |s|
  s.name          = 'catan'
  s.version       = '0.0.1'
  s.summary       = 'The Settlers of Catan board game simulator'
  s.authors       = ['Bartosz Krajka']
  s.email         = 'krajka.bartosz@gmail.com'
  s.files         = ['lib/catan.rb']
  s.license       = 'MIT'
  s.platform      = Gem::Platform.local
  s.add_development_dependency 'overcommit',  '~> 0.46'
  s.add_development_dependency 'reek',        '~> 5.3'
  s.add_development_dependency 'rspec',       '~> 3.7'
  s.add_development_dependency 'rubocop',     '~> 0.62'
end
