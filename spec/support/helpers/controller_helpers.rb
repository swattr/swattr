module Swattr
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      routes { Swattr::Engine.routes }
    end

    def swattr_get(action, parameters = nil, session = nil, flash = nil)
      process_swattr_action(action, parameters, session, flash, "GET")
    end

    def swattr_post(action, parameters = nil, session = nil, flash = nil)
      process_swattr_action(action, parameters, session, flash, "POST")
    end

    def swattr_put(action, parameters = nil, session = nil, flash = nil)
      process_swattr_action(action, parameters, session, flash, "PUT")
    end

    def swattr_delete(action, parameters = nil, session = nil, flash = nil)
      process_swattr_action(action, parameters, session, flash, "DELETE")
    end

    private

    def process_swattr_action(action,
                              parameters = nil,
                              session = nil,
                              flash = nil,
                              method = "GET")
      parameters ||= {}

      process(action, method, parameters, session, flash)
    end
  end
end

RSpec.configure do |config|
  config.include Swattr::ControllerHelpers, type: :controller
end
