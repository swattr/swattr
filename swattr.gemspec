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
  s.add_dependency "highline", "~> 1.7.7"

  s.add_development_dependency "rspec-rails", "~> 3.3.3"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "sqlite3", "~> 1.3.10"
  s.add_development_dependency "simplecov", "~> 0.10.0"
  s.add_development_dependency "database_cleaner", "~> 1.5.0"
  s.add_development_dependency "capybara", "~> 2.5.0"
  s.add_development_dependency "poltergeist", "~> 1.6.0"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "launchy"
end
