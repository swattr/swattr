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

  s.add_dependency "carrierwave", "~> 0.10.0"
  s.add_dependency "date_validator", "~> 0.8.1"
  s.add_dependency "devise", "~> 3.5.2"
  s.add_dependency "devise_invitable", "~> 1.5.3"
  s.add_dependency "file_validators", "~> 2.0.2"
  s.add_dependency "highline", "~> 1.7.8"
  s.add_dependency "human_bytes", "~> 0.11.0"
  s.add_dependency "kaminari", "~> 0.16.3"
  s.add_dependency "local_time", "~> 1.0.3"
  s.add_dependency "mini_magick", "~> 4.3.6"
  s.add_dependency "paranoia", "~> 2.1.4"
  s.add_dependency "pundit", "~> 1.0.1"
  s.add_dependency "ransack", "~> 1.7.0"
  s.add_dependency "responders", "~> 2.1.0"
  s.add_dependency "simple_form", "~> 3.2.0"
  s.add_dependency "validates", "~> 1.0.0"

  s.add_development_dependency "capybara", "~> 2.5.0"
  s.add_development_dependency "database_cleaner", "~> 1.5.1"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "poltergeist", "~> 1.8.0"
  s.add_development_dependency "rspec-rails", "~> 3.4.0"
  s.add_development_dependency "byebug", "~> 8.2.0"
  s.add_development_dependency "coveralls", "~> 0.8.9"
  s.add_development_dependency "launchy", "~> 2.4.3"
  s.add_development_dependency "pry", "~> 0.10.3"
  s.add_development_dependency "simplecov", "~> 0.11.0"
  s.add_development_dependency "sqlite3", "~> 1.3.11"
end
