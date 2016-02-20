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

  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency "rails", ">= 4.2.2"

  s.add_dependency "carrierwave", "~> 0.10"
  s.add_dependency "date_validator", "~> 0.9"
  s.add_dependency "devise", "~> 3.5"
  s.add_dependency "devise_invitable", "~> 1.5"
  s.add_dependency "file_validators", "~> 2.0"
  s.add_dependency "highline", "~> 1.7"
  s.add_dependency "human_bytes", "~> 0.11"
  s.add_dependency "kaminari", "~> 0.16"
  s.add_dependency "local_time", "~> 1.0"
  s.add_dependency "mini_magick", "~> 4.4"
  s.add_dependency "paranoia", "~> 2.1"
  s.add_dependency "pundit", "~> 1.1"
  s.add_dependency "ransack", "~> 1.7"
  s.add_dependency "responders", "~> 2.1"
  s.add_dependency "simple_form", "~> 3.2"
  s.add_dependency "validates", "~> 1.0"

  s.add_development_dependency "byebug"
  s.add_development_dependency "capybara", "~> 2.6"
  s.add_development_dependency "coveralls", "0.8"
  s.add_development_dependency "database_cleaner", "~> 1.5"
  s.add_development_dependency "factory_girl_rails", "~> 4.5"
  s.add_development_dependency "launchy"
  s.add_development_dependency "poltergeist", "~> 1.9"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails", "~> 3.4"
  s.add_development_dependency "sqlite3"
end
