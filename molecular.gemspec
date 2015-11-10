$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "molecular/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "molecular"
  s.version     = Molecular::VERSION
  s.authors     = ["Gabriel Oliveira"]
  s.email       = ["oliveira.gabriel07@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Embeddedable email marketing solution."
  s.description = "Molecular message is the most reliable messaging delivery technology in the world."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
