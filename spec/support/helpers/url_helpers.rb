module Swattr
  module UrlHelpers
    def spree
      Swattr::Engine.routes.url_helpers
    end
  end
end
