module Swattr
  module UrlHelpers
    def swattr
      Swattr::Engine.routes.url_helpers
    end
  end
end

RSpec.configure do |config|
  config.include Swattr::UrlHelpers
end
