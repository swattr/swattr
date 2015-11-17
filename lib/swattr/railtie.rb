module Swattr
  class Railtie < Rails::Railtie
    railtie_name :swattr

    rake_tasks do
      load "tasks/swattr_tasks.rake"
    end
  end
end
