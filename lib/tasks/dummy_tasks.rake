unless defined?(Swattr::Generators::InstallGenerator)
  require "generators/swattr/install/install_generator"
end

require "generators/swattr/dummy/dummy_generator"

desc "Generates a dummy app for testing"
namespace :dummy do
  task :generate do |t, args|
    ENV["RAILS_ENV"] = "test"

    Swattr::Generators::DummyGenerator.start [
      "--lib_name=#{ENV["LIB_NAME"]}",
      "--quiet"
    ]

    Swattr::Generators::InstallGenerator.start [
      "--auto-accept",
      "--skip-migrate",
      "--skip-sample",
      "--skip-seed",
      "--route-path=swattr",
      "--quiet"
    ]

    puts "Setting up dummy database..."
    system("bundle exec rake db:drop db:create db:migrate > #{File::NULL}")

    unless ENV["LIB_NAME"] == "swattr"
      begin
        require "generators/#{ENV["LIB_NAME"]}/install/install_generator"

        puts "Running extension installation generator..."

        "#{ENV["LIB_NAME"].camelize}::Generators::InstallGenerator".
          constantize.
          start([
            "--auto-run-migrations",
            "--auto-accept",
            "--migrate",
            "--skip-sample",
            "--skip-seed",
            "--route-path=swattr",
            "--quiet"
          ])
      rescue LoadError
        puts "Skipping extension instal. No generator to run..."
      end
    end
  end
end
