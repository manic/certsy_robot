$:.push File.expand_path('lib', __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "certsy_robot"
  s.version     = '0.0.1'
  s.authors     = ["Manic Chuang"]
  s.email       = ["manic.chuang@gmail.com"]
  s.homepage    = "https://github.com/manic"
  s.summary     = "Summary of certsy_robot."
  s.description = "Description of certsy_robot."
  s.license     = "MIT"

  s.files = `git ls-files`.split($\)
  s.executables = %w[certsy_robot]
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
end
