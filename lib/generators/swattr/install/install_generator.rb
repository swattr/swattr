require "rails/generators"
require "highline/import"

module Swattr
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option :migrate, type: :boolean, default: true
      class_option :seed, type: :boolean, default: false

      def add_env_file
        say "Copying example .env file..."

        copy_file(".env.example", ".env.example")
      end

      def add_swattr_initializer
        say "Copying Swattr initializer..."

        copy_file("config/initializers/swattr.rb",
                  "config/initializers/swattr.rb")
      end

      def add_swattr_seed
        say "Seeding local seeds.rb..."

        append_file "db/seeds.rb", "Swattr::Engine.load_seed\n"
      end

      def install_migrations
        say "Installing migrations..."

        silence_warnings { rake "railties:install:migrations" }
      end

      def create_database
        say "Creating database..."

        silence_warnings { rake "db:create" }
      end

      def run_migrations
        if options[:migrate]
          say "Running migrations..."

          silence_warnings { rake "db:migrate" }
        else
          say "  Skipping migrations. Be sure to run `rake db:migrate` yourself"
        end
      end

      def seed_database
        if options[:seed] ||
          agree("Would you like to seed the database? (y/N)", false)
          say "Inseminating..."

          quietly { rake "rake db:seed" }
        end
      end

      def insert_routes
        say "Adding Swattr routes..."

        insert_into_file File.join("config", "routes.rb"),
          after: "Rails.application.routes.draw do\n" do
            %Q{
  # This line mounts Swattr's routes at the root of your application. If you
  # would like to change where this engine is mounted, simply change the :at
  # option to reflect your needs.
  mount Swattr::Engine, at: "/"

}
        end

        say "  Your application's config/routes.rb has been updated."
      end

      def complete
        say "Done, sir! Done! Swattr has been installed!"
      end
    end
  end
end
