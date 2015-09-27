module Swattr
  class AuthController < ActionController::Base
    protect_from_forgery with: :exception

    layout :set_layout

    protected

    def set_layout
      "swattr/layouts/auth"
    end
  end
end
