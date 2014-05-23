Gem::Specification.new do |s|
  s.name        = 'pageify'
  s.version     = '0.2.1'
  s.date        = '2014-05-23'
  s.summary     = 'Simplify page object definition for UI tests'
  s.description = "Simplify page object definition for UI tests"
  s.authors     = ["Deepak"]
  s.files       = Dir['README.md', 'lib/**/*']
  s.test_files  = Dir['spec/**/*']
  s.homepage    = 'https://github.com/paramadeep/pageify'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '>=2.10.0'
  s.add_development_dependency 'rake'

end
