module Swattr
  class Engine < ::Rails::Engine
    isolate_namespace Swattr
    engine_name "swattr"

    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en

    config.time_zone = :utc
    config.active_record.default_timezone = :utc

    config.autoload_paths += [
      "#{config.root}/app/modules",
      "#{config.root}/app/services"
    ]

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: true,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
