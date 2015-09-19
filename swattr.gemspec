$:.push File.expand_path("../lib", __FILE__)

require "swattr/version"

Gem::Specification.new do |s|
  s.name        = "swattr"
  s.version     = Swattr::VERSION
  s.authors     = ["David Freerksen", "Aaron Astle", "Josh Boyd"]
  s.homepage    = "https://github.com/swattr/swattr"
  s.summary     = "Summary of Swattr."
  s.description = "Description of Swattr."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
