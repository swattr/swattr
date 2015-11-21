require "rails/generators/rails/app/app_generator"
require "active_support/core_ext/hash"

module Swattr
  module Generators
    class DummyGenerator < Rails::Generators::Base
      desc "Creates blank Rails application, installs Swattr"

      class_option :lib_name, default: ""
      class_option :database, default: ""

      PASSTHROUGH_OPTIONS = [
        :skip_active_record, :skip_javascript, :database, :javascript, :quiet,
        :pretend, :force, :skip
      ]

      source_root File.expand_path("../templates", __FILE__)

      def clean_up
        remove_directory_if_exists(dummy_path)
      end

      def generate_dummy
        opts = {}.merge(options).slice(*PASSTHROUGH_OPTIONS)

        opts[:database] = "sqlite3" if opts[:database].blank?
        opts[:force] = true
        opts[:skip_bundle] = true
        opts[:old_style_hash] = false

        puts "Generating dummy Rails application..."

        invoke Rails::Generators::AppGenerator,
               [ File.expand_path(dummy_path, destination_root) ],
               opts
      end

      def copy_dummy_config
        @lib_name = options[:lib_name]
        @database = options[:database]

        [
          "config/application.rb",
          "config/database.yml"

        ].each do |tpl|
          template tpl, "#{dummy_path}/#{tpl}", force: true
        end
      end

      def test_default_url
        insert_into_file "#{dummy_path}/config/environments/test.rb",
                         after: "Rails.application.configure do\n" do
          <<-DEFAULT_URL
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

            DEFAULT_URL
        end
      end

      def dummy_cleanup
        inside dummy_path do
          [
            ".gitignore",
            "db/seeds.rb",
            "Gemfile",
            "public/robots.txt",
            "lib/tasks",
            "test",
            "vendor"
          ].each do |path|
            remove_file path
          end
        end
      end

      attr :lib_name
      attr :database

      protected

      def remove_directory_if_exists(path)
        remove_dir(path) if File.directory?(path)
      end

      def inject_require_for(requirement)
        inject_into_file "config/application.rb", %Q[
  begin
    require "#{requirement}"
  rescue LoadError
    # #{requirement} is not available.
  end
        ], before: /require "#{@lib_name}"/, verbose: true
      end

      def dummy_path
        ENV["DUMMY_PATH"] || "spec/dummy"
      end
    end
  end
end
