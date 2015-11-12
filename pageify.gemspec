Gem::Specification.new do |s|
  s.name        = 'pageify'
  s.version     = '0.5.1'
  s.date        = '2015-10-31'
  s.summary     = 'Simplify page object definition for UI tests'
  s.description = "Simplify page object definition for UI tests"
  s.authors     = ["Deepak"]
  s.files       = Dir['README.md', 'lib/**/*']
  s.test_files  = Dir['spec/**/*']
  s.homepage    = 'https://github.com/paramadeep/pageify'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rspec'
  s.add_development_dependency 'rspec-mocks'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'capybara'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rubygems-tasks'
  s.add_development_dependency 'simplecov'
end
